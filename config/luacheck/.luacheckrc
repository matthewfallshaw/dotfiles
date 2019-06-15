stds.hammerspoon = {
  read_globals = { 'spoon', 'hs' },
}
std = 'max+hammerspoon'
-- ignore = { '111', '112' }
read_globals = { 'spoon', 'hs' }

files["/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/**/*"].read_globals = { 'hs', 'spoon' }
files["**/hammerspoon_config/**/*"].read_globals = { 'hs', 'spoon' }

-- vim: set filetype=lua:
