# cd up n directories
function cdup
  set -l ups ""
  for i in (seq 1 $argv[1])
    set ups $ups"../"
  end
  cd $ups
end
