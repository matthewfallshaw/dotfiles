-- Terminal hotkeys ⌘1-9 to Tab focus
local logger = hs.logger.new("Terminal Hotkeys")
logger.i("Switching Terminal hotkeys ⌘1-9 to Tab focus")

local M = {}

M.terminal_tab_hotkeys = {}
M.terminal_window_filter = hs.window.filter.new("Terminal")


for i=1,8 do
  M.terminal_tab_hotkeys[i] = hs.hotkey.new('⌘', tostring(i), function()
    hs.osascript.applescript('tell application "Terminal" to set selected of tab ' .. i .. ' of first window to true')
  end)
end
M.terminal_tab_hotkeys[9] = hs.hotkey.new('⌘', "9", function()
  hs.osascript.applescript('tell application "Terminal" to set selected of last tab of first window to true')
end)


local function terminal_tab_hotkeys_enable()
  for i=1,9 do M.terminal_tab_hotkeys[i]:enable() end
  -- Note: Attempting to raise a non-existent tab will cause an Applescript error which
  -- will be harmlessly ignored.
  logger.i("Terminal tab switching hotkeys ⌘1-9 enabled")
end
local function terminal_tab_hotkeys_disable()
  for i=1,9 do M.terminal_tab_hotkeys[i]:disable() end
  logger.i("Terminal tab switching hotkeys ⌘1-9 disabled")
end


function M:start()
  M.terminal_window_filter:subscribe({
    [hs.window.filter.windowFocused] = terminal_tab_hotkeys_enable,
    [hs.window.filter.windowUnfocused] = terminal_tab_hotkeys_disable,
  })
end

function M:stop()
  terminal_tab_hotkeys_disable()
  M.terminal_window_filter:unsubscribe()
end

return M
