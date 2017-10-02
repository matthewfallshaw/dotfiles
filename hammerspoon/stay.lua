-- Keep App windows in their places
local logger = hs.logger.new("Stay")
logger.i("Loading Stay")

local M = {}

M.window_layouts = {} -- see bottom of file


local CHROME_TITLE_REPLACE_STRING = "AEDA6OHZOOBOO4UL8OHH" -- an arbitrary string
local chrome_tab_list_applescript = [[
tell application "Google Chrome"
	set the_tabs to {}
	repeat with the_tab in (tabs of (the first window whose title is "]].. CHROME_TITLE_REPLACE_STRING ..[["))
		set end of the_tabs to {URL of the_tab, title of the_tab}
	end repeat
	return the_tabs
end tell
]]
local function chrome_window_first_tab(window)
  local out, window_tabs_raw, err
  out,window_tabs_raw,err = hs.osascript.applescript(chrome_tab_list_applescript:gsub(CHROME_TITLE_REPLACE_STRING, window:title()))
  if out and window_tabs_raw and window_tabs_raw[1] then
    local first_tab = window_tabs_raw[1]  -- assume the first tab is the interesting one
    local url, title = first_tab[1], first_tab[2]
    return url, title
  else
    -- If tabs change too fast handoff between HS & applescript can fail
    return nil, nil
  end
end

local function escape_for_regexp(str)
  return str:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])","%%%1")
end
local function chrome_window_with_first_tab_matching(window, url_start_target)
  if (window:role() == "AXWindow") and (window:application():name() == "Google Chrome") then
    local url,_= chrome_window_first_tab(window)
    local found = url and url:match("^".. escape_for_regexp(url_start_target))
    return found and true
  else
    return false
  end
end

local chrome_gmail_window_filter = hs.window.filter.new(function(window)
  return chrome_window_with_first_tab_matching(window, "https://mail.google.com/mail/u/0/")
end)

chrome_docs_window_filter = hs.window.filter.new(function(window)
  return chrome_window_with_first_tab_matching(window, "https://drive.google.com/drive/u/0/")
end)

function M:start()
  M.window_layouts_enabled = false
  M:toggle_window_layouts_enabled()
  M.hotkey = M.hotkey and M.hotkey:enable() or hs.hotkey.bind({"⌘", "⌥", "⌃", "⇧"}, "s", function() M.toggle_window_layouts_enabled(M) end)
  return M
end
function M:stop()
  if M.window_layouts_enabled then M:toggle_window_layouts_enabled() end
  M.hotkey:disable()
  return M
end
function M:toggle_window_layouts_enabled()
  if M.window_layouts_enabled then
    for _,layout in pairs(M.window_layouts) do layout:stop() end
    M.window_layouts_enabled = false
    hs.alert.show("Window auto-layout engine paused")
  else
    for _,layout in pairs(M.window_layouts) do layout:start() end
    M.window_layouts_enabled = true
    hs.alert.show("Window auto-layout engine started")
  end
end


M.window_layouts = {
  shared = hs.window.layout.new({
    {chrome_gmail_window_filter, 'move 1 oldest [0,0,77,100] 0,0'},
    {'Morty', 'move 1 oldest [0,0,70,100] 0,0'},
    {{['GitX']={allowScreens='0,0'}}, 'max 1 oldest 0,0'},
    -- allowScreens='0,0' so that it only applies to windows on the main screen, 
    -- so in desk mode i can temporarily "tear off" Safari windows to the side 
    -- screens for manual management
    {{['nvALT']={allowScreens='0,0'}}, 'move 1 oldest [63,0,37,79] 0,0'}, -- creates unitrect=[37,0>63,79]
    {{['Finder']={allowScreens='0,0'}},'move 1 oldest [40,44,94,92] 0,0'},
    {{['Hammerspoon']={allowRoles='AXStandardWindow'}}, 'move 1 oldest [50,0,100,100] 0,0'},
  },'SHARED'),
  laptop = hs.window.layout.new({
    screens={['Color LCD']='0,0',SyncMaster=false,DELL=false}, -- when no external screens
    {chrome_docs_window_filter, 'move 1 oldest [0,0,80,100] 0,0'},
    {'MacVim', 'move 1 oldest [0,0,50,100] 0,0'},
    {'Terminal', 'move 1 oldest [50,0,100,100] 0,0'},
    {{'PivotalTracker','Asana','Google Calendar','Calendar','FreeMindStarter'},
     'max all 0,0'},
  },'LAPTOP'),
  canning = hs.window.layout.new({
    screens={['Color LCD']='0,0',SyncMaster='-1,0',DELL=false},
    {chrome_docs_window_filter, 'move 1 oldest [0,0,90,100] -1,0'},
    {{['MacVim']={allowScreens='-1,0'}}, 'move 1 oldest [0,0,50,100] -1,0'},
    {'Terminal', 'move 1 oldest [50,0,100,100] -1,0'},
    {'PivotalTracker', 'max 1 oldest -1,0'},
    {'Google Calendar', 'max 2 oldest -1,0'},
    {'Calendar', 'max 1 oldest -1,0'},
    {'Asana', 'move 1 oldest [0,0,66,100] -1,0'},
    {'FreeMindStarter', 'move 1 oldest [50,0,100,100] -1,0'},
  },'CANNING'),
  fitzroy = hs.window.layout.new({
    screens={['Color LCD']='0,0',SyncMaster=false,DELL='-1,0'},
    {chrome_docs_window_filter, 'move 1 oldest [10,0,90,100] -1,0'},
    {{['MacVim']={allowScreens='-1,0'}}, 'move 1 oldest [0,0,50,100] -1,0'},
    {'Terminal', 'move 1 oldest [50,0,100,100] -1,0'},
    {'PivotalTracker', 'max 1 oldest -1,0'},
    {'Google Calendar', 'max 2 oldest -1,0'},
    {'Calendar', 'max 1 oldest -1,0'},
    {'Asana', 'move 1 oldest [0,0,66,100] -1,0'},
    {'FreeMindStarter', 'move 1 oldest [50,0,100,100] -1,0'},
  },'FITZROY'),
}

return M
