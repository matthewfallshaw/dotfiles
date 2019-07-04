function cdup -d "cd up n directories"
  set -l ups ""
  for i in (seq 1 $argv[1])
    set ups $ups"../"
  end
  cd $ups
end
