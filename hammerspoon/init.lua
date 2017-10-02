hs.logger.setGlobalLogLevel('info')
hs.logger.defaultLogLevel = 'info'
local logger = hs.logger.new("Init")
hs.console.clearConsole()

-- Load spoons
-- hs.loadSpoon("SpoonInstall")
-- spoon.SpoonInstall.repos.zzspoons = {
--    url = "https://github.com/zzamboni/zzSpoons",
--    desc = "zzamboni's spoon repository",
-- }

-- Load spoon.Hammer first, since it gives us config reload & etc.
hs.loadSpoon("Hammer")
spoon.Hammer:bindHotkeys({
  config_reload ={{"⌘", "⌥", "⌃", "⇧"}, "r"},
  toggle_console={{"⌘", "⌥", "⌃", "⇧"}, "h"},
})
spoon.Hammer:start()

hs.application.enableSpotlightForNameSearches(true)
hs.allowAppleScript(true)


u = require 'utilities'


-- Control Plane replacement
controlplane = require 'control-plane'
controlplane:start()


-- ScanSnap
logger.i("Loading ScanSnap USB watcher")
function usbDeviceCallback(data)
  if (data["productName"]:match("^ScanSnap")) then
    if (data["eventType"] == "added") then
      u.log_and_alert(logger, data["productName"].. " added, launching ScanSnap Manager")
      hs.application.launchOrFocus("ScanSnap Manager")
    elseif (data["eventType"] == "removed") then
      local app = hs.application.find("ScanSnap Manager")
      if app then
        u.log_and_alert(logger, data["productName"].. " removed, closing ScanSnap Manager")
        app:kill()
      end
      if hs.application.get("AOUMonitor") then hs.application.get("AOUMonitor"):kill9() end
    end
  end
end
usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
logger.i("Starting ScanSnap USB watcher")
usbWatcher:start()


-- Jettison
logger.i("Loading Jettison sleep watcher")
function sleepWatcherCallback(event)
  if event == hs.caffeinate.watcher.systemWillSleep then
    local result, output = hs.osascript.applescript('tell application "Finder" to return (URL of every disk whose ejectable is true)')
    if output then
      hs.caffeinate.declareUserActivity()  -- prevent sleep to give us time to eject drives
      u.log_and_alert(logger, "Ejecting drives before sleep…")
      hs.osascript.applescript('tell application "Finder" to eject (every disk whose ejectable is true)')
      u.log_and_alert(logger, "… drives ejected.")
      hs.caffeinate.systemSleep()
    end
  end
end
sleepWatcher = hs.caffeinate.watcher.new(sleepWatcherCallback)
logger.i("Starting Jettison sleep watcher")
sleepWatcher:start()


-- Transmission safety
logger.i("Loading Transmission VPN Guard")
function applicationWatcherCallback(appname, event, app)
  if appname == "Transmission" and event == hs.application.watcher.launching then
    if not hs.application.get("Private Internet Access") then
      u.log_and_alert(logger, "Transmission launch detected… launching PIA")
      hs.application.open("Private Internet Access")
    else
      u.log_and_alert(logger, "Transmission launch detected… but PIA already running")
    end
  elseif appname == "Private Internet Access" and event == hs.application.watcher.terminated then
    if hs.application.get("Transmission") then
      u.log_and_alert(logger, "PIA termination detected… killing Transmission")
      hs.application.get("Transmission"):kill9()
    else
      u.log_and_alert(logger, "PIA termination detected… Transmission not running, so no action")
    end
  end
end
applicationWatcher = hs.application.watcher.new(applicationWatcherCallback)
logger.i("Starting Transmission VPN Guard")
applicationWatcher:start()


-- Garmin auto ejector
logger.i("Loading Garmin volume auto-ejector")
function garminEjectWatcherCallback(event, info)
  if event == hs.fs.volume.didMount and info.path:match("/Volumes/GARMIN") then
    u.log_and_alert(logger, "Garmin volume mounted… go away pesky Garmin volume")
    hs.fs.volume.eject(info.path)
  end
end
garminEjectWatcher = hs.fs.volume.new(garminEjectWatcherCallback)
logger.i("Starting Garmin volume auto-ejector")
garminEjectWatcher:start()


-- Terminal.app Hotkeys ⌘1-9 to switch tabs
terminal_hotkeys = require 'terminal-hotkeys'
terminal_hotkeys:start()


-- iTunes Hotkeys
hs.itunes = require 'extensions/itunes'
itunes_hotkeys = {}
local ituneshotkeymap = {
  playpause = {{"⌥", "⌃", "⇧"}, "p"},
  next      = {{"⌥", "⌃", "⇧"}, "n"},
  like      = {{"⌥", "⌃", "⇧"}, "l"},
  dislike   = {{"⌥", "⌃", "⇧"}, "d"},
  hide      = {{"⌥", "⌃", "⇧"}, "h"},
  quit      = {{"⌥", "⌃", "⇧"}, "q"},
  -- mute      = {{"⌥", "⌃", "⇧"}, "f10"},
  volumeDown= {{"⌥", "⌃", "⇧"}, "f11"},
  volumeUp  = {{"⌥", "⌃", "⇧"}, "f12"},
}
for fn, map in pairs(ituneshotkeymap) do
  itunes_hotkeys[fn] = hs.hotkey.bind(map[1], map[2], function() hs.itunes[fn]() end)
end


-- URLs from hammerspoon:// schema
local function hex_to_char(x)
  return string.char(tonumber(x, 16))
end
local function unescape(url)
  return url:gsub("%%(%x%x)", hex_to_char)
end
function URLDispatcherCallback(eventName, params)
  local fullUrl = unescape(params.uri)
  local parts = hs.http.urlParts(fullUrl)
  spoon.URLDispatcher:dispatchURL(parts.scheme, parts.host, parts.parameterString, fullUrl)
end
url_dispatcher = hs.urlevent.bind("URLDispatcher", URLDispatcherCallback)


-- Spoons (other than spoon.Hammer)
-- ## All hosts
hs.loadSpoon("URLDispatcher")
spoon.URLDispatcher.default_handler = "com.google.Chrome"
spoon.URLDispatcher.url_patterns = {
  -- { "url pattern", "application bundle ID" },
  { "https?://www.pivotaltracker.com/.*", "com.fluidapp.FluidApp.PivotalTracker" },
  { "https?://morty.trikeapps.com/.*",    "org.epichrome.app.Morty" },
  { "https?://app.asana.com/.*",          "org.epichrome.app.Asana" },
}
spoon.URLDispatcher:start()

hs.loadSpoon("Emojis")
spoon.Emojis:bindHotkeys({ toggle    = {{"⌘", "⌥", "⌃", "⇧"}, "space"}})

hs.loadSpoon("MouseCircle")
spoon.MouseCircle:bindHotkeys({ show = {{"⌘", "⌥", "⌃", "⇧"}, "m"}})

hs.loadSpoon("Caffeine")
spoon.Caffeine:bindHotkeys({ toggle  = {{"⌥", "⌃", "⇧"}, "c"}})
spoon.Caffeine:start()

hs.loadSpoon("HeadphoneAutoPause")
spoon.HeadphoneAutoPause.control['vox'] = nil
spoon.HeadphoneAutoPause.control['deezer'] = nil
spoon.HeadphoneAutoPause.controlfns['vox'] = nil
spoon.HeadphoneAutoPause.controlfns['deezer'] = nil
spoon.HeadphoneAutoPause:start()

-- Keep App windows in their places
stay = require('stay')
stay:start()

-- ## notnux only
if hs.host.localizedName() == "notnux" then

  -- hs.loadSpoon("ToggleSkypeMute")
  -- spoon.ToggleSkypeMute:bindHotkeys( {
  --   toggle_skype={{"⌘", "⌥", "⌃", "⇧"}, "v"},
  -- })

end

hs.loadSpoon("FadeLogo"):start()
