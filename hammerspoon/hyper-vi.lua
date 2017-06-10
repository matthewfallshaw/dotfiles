local logger = hs.logger.new("HyperVI")
logger.i("Loading HyperVI")

local obj = {}

-- A global variable for the sub-key Hyper Mode
local k = hs.hotkey.modal.new({}, 'F18')

-- Enter Hyper Mode when F19 is pressed
-- Use Karabiner-Elements to bind CAPS-LOCK to F19
local pressedF19 = function()
--  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F19 is released,
--   send ESCAPE if no other keys are pressed.
local releasedF19 = function()
  k:exit()
--  if not k.triggered then
--    hs.eventtap.keyStroke({}, 'ESCAPE')
--  end
end

-- Bind the Hyper key
logger.i("Binding F19")
local f19 = hs.hotkey.bind({}, 'F19', pressedF19, releasedF19)
local cmdf19 = hs.hotkey.bind({'cmd','fn'}, 'F19', pressedF19, releasedF19)
local altf19 = hs.hotkey.bind({'alt','fn'}, 'F19', pressedF19, releasedF19)

-- vi cursor movement commands
local movements = {
 { 'h', 'LEFT'},
 { 'j', 'DOWN'},
 { 'k', 'UP'},
 { 'l', 'RIGHT'},
}
logger.i("Binding Vi keys")
local modifiers = { {''}, {'shift'}, {'alt'}, {'cmd'}, {'shift','alt'}, {'shift','cmd'}, }
for i,bnd in ipairs(movements) do
  for i,mod in ipairs(modifiers) do
    k:bind(mod, bnd[1], function()
      hs.eventtap.keyStroke(mod, bnd[2])
--      k.triggered = true
    end)
  end
end

return obj
