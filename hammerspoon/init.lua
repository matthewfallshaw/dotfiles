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
hs.alert.show('Config loaded')
