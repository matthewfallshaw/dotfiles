# Make a directory and cd into it
function mcd
  mkdir -p "$argv[1]"; and cd "$argv[1]"
end
