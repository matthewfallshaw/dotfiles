hs.logger.setGlobalLogLevel('info')
hs.logger.defaultLogLevel = 'info'
local logger = hs.logger.new("Init")

-- Load Spoon.Hammer first, since it gives us config reload & etc.
hs.loadSpoon("Hammer")
spoon.Hammer:bindHotkeys({
  config_reload ={{"⌘", "⌥", "⌃", "⇧"}, "r"},
  toggle_console={{"⌘", "⌥", "⌃", "⇧"}, "h"},
})
spoon.Hammer:start()

hypervi      = require 'hyper-vi'

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


-- Spoons (other than Spoon.Hammer)
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
})

-- hs.loadSpoon("HeadphoneWatcher")
-- spoon.HeadphoneWatcher.controlfns = {
--   ["hermes"] = {
--     appname   = "Hermes",
--     isPlaying = function() return spoon.Hermes.isPlaying() end,
--     play      = spoon.Hermes.play,
--     pause     = spoon.Hermes.pause
--   },
--   ["itunes"]  = spoon.HeadphoneWatcher.controlfns["itunes"],
--   ["spotify"] = spoon.HeadphoneWatcher.controlfns["spotify"],
-- }
-- spoon.HeadphoneWatcher:start()

hs.loadSpoon("ToggleSkypeMute")
spoon.ToggleSkypeMute:bindHotkeys( {
  toggle_skype={{"⌘", "⌥", "⌃", "⇧"}, "v"},
})


-- oh my hammerspoon
logger.i("Loading oh-my-hammerspoon")
require("oh-my-hammerspoon")
omh_go({ "audio.headphones_watcher" })



hs.alert.show('Config loaded')
