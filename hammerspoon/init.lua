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


controlplane = require 'control-plane'
controlplane:start()
stay         = require 'stay'
stay:start()


-- ScanSnap
logger.i("Loading ScanSnap USB watcher")
local usbWatcher = nil
function usbDeviceCallback(data)
    if (data["productName"] == "ScanSnap S1300i") then
        if (data["eventType"] == "added") then
            hs.application.launchOrFocus("ScanSnap Manager")
        elseif (data["eventType"] == "removed") then
            local app = hs.appfinder.appFromName("ScanSnap Manager")
            app:kill()
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
    logger.i("Ejecting drives before sleep…")
    hs.alert.show("Ejecting drives before sleep…")
    hs.osascript.applescript("tell application \"Finder\" to eject (every disk whose ejectable is true)")
    logger.i("… ejected.")
    hs.alert.show("… ejected.")
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
  end
end
applicationWatcher = hs.application.watcher.new(applicationWatcherCallback)
logger.i("Starting Transmission VPN Guard")
applicationWatcher:start()


-- Spoons (other than Spoon.Hammer)
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
spoon.Caffeine:bindHotkeys({ toggle  = {{"⌘", "⌥", "⌃", "⇧"}, "c"}})
spoon.Caffeine:start()

hs.loadSpoon("Hermes")
spoon.Hermes:bindHotkeys( {
  playpause = {{"⌥", "⌃", "⇧"}, "p"},
  next      = {{"⌥", "⌃", "⇧"}, "n"},
  like      = {{"⌥", "⌃", "⇧"}, "l"},
  dislike   = {{"⌥", "⌃", "⇧"}, "d"},
  tired     = {{"⌥", "⌃", "⇧"}, "t"},
  hide      = {{"⌥", "⌃", "⇧"}, "h"},
  quit      = {{"⌥", "⌃", "⇧"}, "q"},
  mute      = {{"⌥", "⌃", "⇧"}, "f10"},
  volumeDown= {{"⌥", "⌃", "⇧"}, "f11"},
  volumeUp  = {{"⌥", "⌃", "⇧"}, "f12"},
})

hs.loadSpoon("HeadphoneAutoPause")
spoon.HeadphoneAutoPause.control['vox'] = false
spoon.HeadphoneAutoPause.control['deezer'] = false
spoon.HeadphoneAutoPause.control['hermes'] = true
spoon.HeadphoneAutoPause.controlfns['hermes'] = {
  appname   = 'Hermes',
  isPlaying = function() return spoon.Hermes.isPlaying() end,
  play      = spoon.Hermes.play,
  pause     = spoon.Hermes.pause,
}
spoon.HeadphoneAutoPause:start()

-- ## notnux only
if hs.host.localizedName() == "notnux" then

  -- hs.loadSpoon("ToggleSkypeMute")
  -- spoon.ToggleSkypeMute:bindHotkeys( {
  --   toggle_skype={{"⌘", "⌥", "⌃", "⇧"}, "v"},
  -- })

end

hs.loadSpoon("FadeLogo"):start()
