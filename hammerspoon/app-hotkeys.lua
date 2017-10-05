-- App hotkeys
--
-- Add hs.hotkey.new (not .bind) to M.hotkeys["<hs.application:name()>"]. Add
--   app_hotkeys = require 'app-hotkeys'
--   app_hotkeys:start()
-- to your init.lua and they will be enabled whenever the app has focus and
-- disabled when it loses focus.

local logger = hs.logger.new("App Hotkeys")

local M = { hotkeys = {}, window_filters = {} }
setmetatable(M.hotkeys, { __index = function(t,k) t[k]={}; return t[k] end }) -- initialise M.hotkeys.? = {}


-- Terminal ⌘1-9 to tab focus
logger.i("Terminal hotkeys for switching ⌘1-9 to Tab focus")
for i=1,8 do
  -- Note: Attempting to raise a non-existent tab will cause an Applescript error which
  -- will be harmlessly ignored.
  M.hotkeys["Terminal"][i] = hs.hotkey.new('⌘', tostring(i), function()
    hs.osascript.applescript('tell application "Terminal" to set selected of tab ' .. i .. ' of first window to true')
  end)
end
M.hotkeys["Terminal"][9] = hs.hotkey.new('⌘', "9", function()
  hs.osascript.applescript('tell application "Terminal" to set selected of last tab of first window to true')
end)



-- Utility functions
local function windowFocused(window, application_name, event)
  for _,hotkey in pairs(M.hotkeys[application_name]) do hotkey:enable() end
  logger.i(application_name .. " hotkeys enabled")
end
local function windowUnfocused(window, application_name, event)
  for _,hotkey in pairs(M.hotkeys[application_name]) do hotkey:disable() end
  logger.i(application_name .. " hotkeys disabled")
end

-- Module methods
function M:start()
  for app,_ in pairs(self.hotkeys) do
    self.window_filters[app] = hs.window.filter.new(app)
    self.window_filters[app]:subscribe({
      [hs.window.filter.windowFocused] = windowFocused,
      [hs.window.filter.windowVisible] = windowFocused, -- because focusing a hidden app doesn't trigger windowFocused
      [hs.window.filter.windowUnfocused] = windowUnfocused,
    })
  end
end

function M:stop()
  for _,f in pairs(self.window_filters) do
    for fn,_ in pairs(f.events.windowUnfocused) do fn() end
    f:unsubscribeAll()
  end
end


return M
