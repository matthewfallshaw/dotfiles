hs.logger.setGlobalLogLevel('info')
hs.logger.defaultLogLevel = 'info'
local logger = hs.logger.new("Init")

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


-- Control Plane replacement
controlplane = require 'control-plane'
controlplane:start()


-- ScanSnap
logger.i("Loading ScanSnap USB watcher")
usbWatcher = nil
function usbDeviceCallback(data)
  if (data["productName"]:match("^ScanSnap")) then
    if (data["eventType"] == "added") then
      logger.i(data["productName"].. " added, launching ScanSnap Manager")
      hs.application.launchOrFocus("ScanSnap Manager")
    elseif (data["eventType"] == "removed") then
      local app = hs.application.find("ScanSnap Manager")
      if app then
        logger.i(data["productName"].. " removed, closing ScanSnap Manager")
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
      logger.i("Ejecting drives before sleep…")
      hs.alert.show("Ejecting drives before sleep…")
      hs.osascript.applescript('tell application "Finder" to eject (every disk whose ejectable is true)')
      logger.i("… drives ejected.")
      hs.alert.show("… drives ejected.")
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
    logger.i("Transmission launch detected…")
    if not hs.application.get("Private Internet Access") then
      logger.i("… launching PIA")
      hs.application.open("Private Internet Access")
    else
      logger.i("… but PIA already running")
    end
  elseif appname == "Private Internet Access" and event == hs.application.watcher.terminated then
    logger.i("PIA termination detected…")
    if hs.application.get("Transmission") then
      logger.i("… killing Transmission")
      hs.application.get("Transmission"):kill9()
    else
      logger.i("… Transmission not running, so no action")
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
    logger.i("Garmin volume mounted… go away pesky Garmin volume")
    hs.alert.show("Garmin volume mounted… go away pesky Garmin volume")
    hs.fs.volume.eject(info.path)
  end
end
garminEjectWatcher = hs.fs.volume.new(garminEjectWatcherCallback)
logger.i("Starting Garmin volume auto-ejector")
garminEjectWatcher:start()


-- iTunes
hs.itunes = require 'extensions/itunes'
ituneshotkeys = {}
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
  ituneshotkeys[fn] = hs.hotkey.bind(map[1], map[2], nil, function() hs.itunes[fn]() end)
end


-- URLs from hammerspoon:// schema
local hex_to_char = function(x)
  return string.char(tonumber(x, 16))
end
local unescape = function(url)
  return url:gsub("%%(%x%x)", hex_to_char)
end
function URLDispatcherCallback(eventName, params)
  local fullUrl = unescape(params.uri)
  local parts = hs.http.urlParts(fullUrl)
  spoon.URLDispatcher:dispatchURL(parts.scheme, parts.host, parts.parameterString, fullUrl)
end
hs.urlevent.bind("URLDispatcher", URLDispatcherCallback)


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

hs.loadSpoon("RestoreWindows")
spoon.RestoreWindows.locationFunction = function() return controlplane.location() end
spoon.RestoreWindows.appLayouts = {
  ["*"] = {
         -- {window title, screen name, unit rect, frame rect, full-frame rect}
    Morty = {nil, "Color LCD", hs.geometry.unitrect(0,0,0.7,1), nil, nil},
    GitX = {nil, "Color LCD", hs.layout.maximized, nil, nil},
    nvALT = {nil, "Color LCD", hs.geometry.unitrect(0.63, 0.0, 0.37, 0.79), nil, nil},
  },
  Canning = {
    MacVim = {nil, "SyncMaster", hs.layout.left50, nil, nil},
    Terminal = {nil, "SyncMaster", hs.layout.right50, nil, nil},
    PivotalTracker = {nil, "SyncMaster", hs.layout.maximized, nil, nil},
    Asana = {nil, "SyncMaster", hs.geometry.unitrect(0,0,0.66,1), nil, nil},
    ["Google Calendar"] = {nil, "SyncMaster", hs.layout.maximized, nil, nil},
    Calendar = {nil, "SyncMaster", hs.layout.maximized, nil, nil},
    FreeMindStarter = {nil, "SyncMaster", hs.layout.right50, nil, nil},
    ["Google Chrome"] = [[
-- restoreChromeWindow(target_url_start, target_title_end, target_tab_name, target_position, target_size, target_url_exclude)

tell script "Raise in Chrome Library.scpt"
  restoreChromeWindow("https://mail.google.com/mail/u/0/", " - Gmail", "Gmail", {0, 23}, {1111, 873}, "ui=2")
  restoreChromeWindow("https://drive.google.com/drive/u/0/", " - Google Drive", "Personal Docs", {-1526, -750}, {1190, 1080}, "")
end tell
  ]],
  },
  Fitzroy = {
    MacVim = {nil, "DELL 2408WFP", hs.layout.left50, nil, nil},
    Terminal = {nil, "DELL 2408WFP", hs.layout.right50, nil, nil},
    PivotalTracker = {nil, "DELL 2408WFP", hs.layout.maximized, nil, nil},
    Asana = {nil, "DELL 2408WFP", hs.geometry.unitrect(0,0,0.66,1), nil, nil},
    ["Google Calendar"] = {nil, "DELL 2408WFP", hs.layout.maximized, nil, nil},
    Calendar = {nil, "DELL 2408WFP", hs.layout.maximized, nil, nil},
    FreeMindStarter = {nil, "DELL 2408WFP", hs.layout.right50, nil, nil},
    ["Google Chrome"] = [[
-- restoreChromeWindow(target_url_start, target_title_end, target_tab_name, target_position, target_size, target_url_exclude)

tell script "Raise in Chrome Library.scpt"
  restoreChromeWindow("https://mail.google.com/mail/u/0/", " - Gmail", "Gmail", {0, 23}, {1111, 873}, "ui=2")
  restoreChromeWindow("https://drive.google.com/drive/u/0/", " - Google Drive", "Personal Docs", {-1526, -447}, {1190, 1200}, "")
end tell
  ]],
  },
  Roaming = {
    MacVim = {nil, "Color LCD", hs.layout.left50, nil, nil},
    Terminal = {nil, "Color LCD", hs.layout.right50, nil, nil},
    PivotalTracker = {nil, "Color LCD", hs.layout.maximized, nil, nil},
    Asana = {nil, "Color LCD", hs.layout.maximized, nil, nil},
    ["Google Calendar"] = {nil, "Color LCD", hs.layout.maximized, nil, nil},
    Calendar = {nil, "Color LCD", hs.layout.maximized, nil, nil},
    FreeMindStarter = {nil, "Color LCD", hs.layout.maximized, nil, nil},
    ["Google Chrome"] = [[
-- restoreChromeWindow(target_url_start, target_title_end, target_tab_name, target_position, target_size)

tell script "Raise in Chrome Library.scpt"
  restoreChromeWindow("https://mail.google.com/mail/u/0/", " - Gmail", "Gmail", {0, 23}, {1111, 873}, "ui=2")
  restoreChromeWindow("https://drive.google.com/drive/u/0/", " - Google Drive", "Personal Docs", {0, 23}, {1111, 873})
end tell
  ]],
  },
}
spoon.RestoreWindows.appLayouts["iPhone"] = spoon.RestoreWindows.appLayouts["Roaming"]
spoon.RestoreWindows:bindHotkeys({
  restoreOrChooser = {{"⌘", "⌥", "⌃", "⇧"}, "s"},
})
spoon.RestoreWindows:start()
-- RestoreWindows only restores windows in the current space; trigger it on space change
-- TODO: only do this once per controlplane location change
space_change_watcher = hs.spaces.watcher.new(function(space_number) spoon.RestoreWindows:restoreWindows() end):start()

-- ## notnux only
if hs.host.localizedName() == "notnux" then

  -- hs.loadSpoon("ToggleSkypeMute")
  -- spoon.ToggleSkypeMute:bindHotkeys( {
  --   toggle_skype={{"⌘", "⌥", "⌃", "⇧"}, "v"},
  -- })

end

hs.loadSpoon("FadeLogo"):start()
