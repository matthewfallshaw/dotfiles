require 'hyper-vi'

-- ScanSnap
local usbWatcher = nil
function usbDeviceCallback(data)
    if (data["productName"] == "ScanSnap S1300i") then
        if (data["eventType"] == "added") then
            hs.application.launchOrFocus("ScanSnap Manager")
        elseif (data["eventType"] == "removed") then
            app = hs.appfinder.appFromName("ScanSnap Manager")
            app:kill()
        end
    end
end
usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
usbWatcher:start()


-- Reload config when any lua file in config directory changes
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == '.lua' then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
local myWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reloadConfig):start()


-- Spoons
hs.loadSpoon("URLDispatcher")
spoon.URLDispatcher.default_handler = "com.google.Chrome"
spoon.URLDispatcher.url_patterns = {
  { "url pattern", "application bundle ID" },
  { "https?://www.pivotaltracker.com/.*", "com.fluidapp.FluidApp.PivotalTracker" },
  { "https?://morty.trikeapps.com/.*", "org.epichrome.app.Morty" },
  { "https?://app.asana.com/.*", "org.epichrome.app.Asana" },
}
spoon.URLDispatcher:start()

hs.loadSpoon("Emojis")
spoon.Emojis:bindHotkeys({ toggle={{"⌘", "⌥", "⌃", "⇧"}, "space"}, })

hs.loadSpoon("MouseCircle")
spoon.MouseCircle:bindHotkeys({show={{"⌘", "⌥", "⌃", "⇧"}, "m"}})

hs.loadSpoon("Caffeine")
spoon.Caffeine:bindHotkeys({toggle={{"⌘", "⌥", "⌃", "⇧"}, "c"}})
spoon.Caffeine:start()

hs.loadSpoon("Hermes")
hs.alert.show('Config loaded')
