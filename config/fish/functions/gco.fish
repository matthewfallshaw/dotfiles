function gco
  if [ -z "$argv[1]" ]; then
    git checkout master
  else
    git checkout $argv[1]
  end
end
