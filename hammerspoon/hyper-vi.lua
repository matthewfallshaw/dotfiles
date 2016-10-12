-- A global variable for the sub-key Hyper Mode
k = hs.hotkey.modal.new({}, 'F18')

-- Enter Hyper Mode when F19 is pressed
-- Use Karabiner-Elements to bind CAPS-LOCK to F19
pressedF19 = function()
--  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F19 is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF19 = function()
  k:exit()
--  if not k.triggered then
--    hs.eventtap.keyStroke({}, 'ESCAPE')
--  end
end

-- Bind the Hyper key
f19 = hs.hotkey.bind({}, 'F19', pressedF19, releasedF19)
cmdf19 = hs.hotkey.bind({'cmd','fn'}, 'F19', pressedF19, releasedF19)
altf19 = hs.hotkey.bind({'alt','fn'}, 'F19', pressedF19, releasedF19)

-- vi cursor movement commands
movements = {
 { 'h', 'LEFT'},
 { 'j', 'DOWN'},
 { 'k', 'UP'},
 { 'l', 'RIGHT'},
}
modifiers = { {''}, {'shift'}, {'alt'}, {'cmd'}, {'shift','alt'}, {'shift','cmd'}, }
for i,bnd in ipairs(movements) do
  for i,mod in ipairs(modifiers) do
    k:bind(mod, bnd[1], function()
      hs.eventtap.keyStroke(mod,bnd[2])
--      k.triggered = true
    end)
  end
end
