local logger = hs.logger.new("App Hotkeys")

local M = { hotkeys = {}, window_filters = {} }
setmetatable(M.hotkeys, { __index = function(t,k) t[k]={}; return t[k] end }) -- initialise M.hotkeys.? = {}


-- Terminal hotkeys ⌘1-9 to Tab focus
logger.i("Terminal hotkeys for switching ⌘1-9 to Tab focus")
for i=1,8 do
  -- Note: Attempting to raise a non-existent tab will cause an Applescript error which
  -- will be harmlessly ignored.
  M.hotkeys.terminal[i] = hs.hotkey.new('⌘', tostring(i), function()
    hs.osascript.applescript('tell application "Terminal" to set selected of tab ' .. i .. ' of first window to true')
  end)
end
M.hotkeys.terminal[9] = hs.hotkey.new('⌘', "9", function()
  hs.osascript.applescript('tell application "Terminal" to set selected of last tab of first window to true')
end)


local function appname(app)
  local appname = app:gsub("^%l", string.upper)
  return appname
end


function M:start()
  for app,_ in pairs(self.hotkeys) do
    self.window_filters[app] = hs.window.filter.new(appname(app))
    self.window_filters[app]:subscribe({
      [hs.window.filter.windowFocused] = function()
        for _,hotkey in pairs(M.hotkeys[app]) do hotkey:enable() end
        logger.i(app .. " hotkeys enabled")
      end,
      [hs.window.filter.windowUnfocused] = function()
        for _,hotkey in pairs(M.hotkeys[app]) do hotkey:disable() end
        logger.i(app .. " hotkeys disabled")
      end
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
