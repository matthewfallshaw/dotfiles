require 'hyper-vi'

-- ScanSnap
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
usbWatcher:start()


-- Spoons
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
spoon.Emojis:bindHotkeys({ toggle=  {{"⌘", "⌥", "⌃", "⇧"}, "space"}, })

hs.loadSpoon("MouseCircle")
spoon.MouseCircle:bindHotkeys({show={{"⌘", "⌥", "⌃", "⇧"}, "m"}})

hs.loadSpoon("Caffeine")
spoon.Caffeine:bindHotkeys({toggle= {{"⌘", "⌥", "⌃", "⇧"}, "c"}})
spoon.Caffeine:start()

hs.loadSpoon("Hermes")
spoon.Hermes:bindHotkeys( {
  playpause={{"⌥", "⌃", "⇧"}, "p"},
  next=     {{"⌥", "⌃", "⇧"}, "n"},
  like=     {{"⌥", "⌃", "⇧"}, "l"},
  dislike=  {{"⌥", "⌃", "⇧"}, "d"},
  tired=    {{"⌥", "⌃", "⇧"}, "t"},
  hide=     {{"⌥", "⌃", "⇧"}, "h"},
  quit=     {{"⌥", "⌃", "⇧"}, "q"},
})

hs.loadSpoon("Hammer")
spoon.Hammer:bindHotkeys({
  config_reload= {{"⌘", "⌥", "⌃", "⇧"}, "r"},
  toggle_console={{"⌘", "⌥", "⌃", "⇧"}, "h"},
})
spoon.Hammer:start()


-- oh my hammerspoon
require("oh-my-hammerspoon")
omh_go({
      -- "apps.hammerspoon_toggle_console",
      -- "apps.hammerspoon_install_cli",
      -- "apps.hammerspoon_config_reload",
      -- "windows.manipulation",
      -- "windows.grid",
      "apps.skype_mute",
      -- "mouse.locator",
      "audio.headphones_watcher",
      -- "misc.clipboard",
      -- "misc.colorpicker",
      -- "keyboard.menubar_indicator",
      -- "apps.universal_archive",
      -- "apps.universal_omnifocus",
      -- "windows.screen_rotate",
      "apps.evernote",
       })



hs.alert.show('Config loaded')
