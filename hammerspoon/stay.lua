local logger = hs.logger.new("Stay")
logger.i("Loading Stay")

local obj = {}
obj.hotkeys = {}

function obj:start()
  for k,v in pairs(obj) do
    -- if type(v) == 'function' and string.find(k, "Callback$") then
    --   v()
    -- end
    if type(v) == 'userdata' and string.find(k, "Watcher$") then
      logger.i("Starting " .. k)
      v:start()
    end
  end
  obj.hotkeys["Restore windows"] = hs.hotkey.bind({"⌘", "⌥", "⌃", "⇧"}, "s", obj.screenCallback)
  return obj
end

function obj.screenCallback()
  if controlplane and controlplane.cachedLocation and obj[controlplane.cachedLocation:lower() .. "Restore"] then
    obj[controlplane.cachedLocation:lower() .. "Restore"]()
  elseif controlplane and controlplane.cachedLocation then
    logger.w("I don't know how to restore windows for " .. controlplane.cachedLocation)
  else
    logger.e("Can't find controlplane")
  end
end
obj.screenWatcher = hs.screen.watcher.new(obj.screenCallback)

function obj.commonRestore()
  hs.layout.apply({
    -- Application name, window title, screen name, unit rect, frame rect, full-frame rect
    {"Terminal", nil, "SyncMaster", hs.layout.right50, nil, nil},
    {"MacVim", nil, "SyncMaster", hs.layout.left50, nil, nil},
    {"FreeMindStarter", nil, "SyncMaster", hs.layout.right50, nil, nil}, -- Freemind
    {"PivotalTracker", nil, "SyncMaster", hs.layout.maximized, nil, nil},
    {"Google Calendar", nil, "SyncMaster", hs.layout.maximized, nil, nil},
    {"Calendar", nil, "SyncMaster", hs.layout.maximized, nil, nil},
    {"Morty", nil, "Color LCD", hs.geometry.unitrect(0,0,0.7,1), nil, nil},
    {"Asana", nil, "SyncMaster", hs.geometry.unitrect(0,0,0.66,1), nil, nil},
  }, string.match)
end
function obj.canningRestore()
  logger.i("Restoring Canning screens")
  obj.commonRestore()
  -- Chrome
  bool, object, descriptor = hs.osascript.applescript([[
-- restoreChromeWindow(target_url_start, target_title_end, target_tab_name, target_position, target_size, target_url_exclude)

tell script "Raise in Chrome Library.scpt"
	restoreChromeWindow("https://mail.google.com/mail/u/0/", " - Gmail", "Gmail", {0, 23}, {1111, 873}, "ui=2")
	restoreChromeWindow("https://drive.google.com/drive/u/0/", " - Google Drive", "Personal Docs", {-1526, -481}, {1190, 1080}, "")
end tell
  ]])
end
function obj.fitzroyRestore()
  logger.i("Restoring Fitzroy screens")
  obj.commonRestore()
  -- Chrome
  bool, object, descriptor = hs.osascript.applescript([[
-- restoreChromeWindow(target_url_start, target_title_end, target_tab_name, target_position, target_size, target_url_exclude)

tell script "Raise in Chrome Library.scpt"
	restoreChromeWindow("https://mail.google.com/mail/u/0/", " - Gmail", "Gmail", {0, 23}, {1111, 873}, "ui=2")
	restoreChromeWindow("https://drive.google.com/drive/u/0/", " - Google Drive", "Personal Docs", {-1526, -300}, {1190, 1200}, "")
end tell
  ]])
end
function obj.roamingRestore()
  logger.i("Restoring Roaming screens")
  hs.layout.apply({
    -- Application name, window title, screen name, unit rect, frame rect, full-frame rect
    {"Terminal", nil, "Color LCD", hs.layout.right50, nil, nil},
    {"MacVim", nil, "Color LCD", hs.layout.left50, nil, nil},
    {"FreeMindStarter", nil, "Color LCD", hs.layout.maximized, nil, nil}, -- Freemind
    {"PivotalTracker", nil, "Color LCD", hs.layout.maximized, nil, nil},
    {"Google Calendar", nil, "Color LCD", hs.layout.maximized, nil, nil},
    {"Calendar", nil, "Color LCD", hs.layout.maximized, nil, nil},
    {"Morty", nil, "Color LCD", hs.geometry.unitrect(0,0,0.7,1), nil, nil},
    {"Asana", nil, "Color LCD", hs.geometry.unitrect(0,0,0.66,1), nil, nil},
  }, string.match)
  -- Chrome
  bool, object, descriptor = hs.osascript.applescript([[
-- restoreChromeWindow(target_url_start, target_title_end, target_tab_name, target_position, target_size, target_url_exclude)

tell script "Raise in Chrome Library.scpt"
	restoreChromeWindow("https://mail.google.com/mail/u/0/", " - Gmail", "Gmail", {0, 23}, {1111, 873}, "ui=2")
	restoreChromeWindow("https://drive.google.com/drive/u/0/", " - Google Drive", "Personal Docs", {0, 23}, {1111, 873})
end tell
  ]])
end

return obj
