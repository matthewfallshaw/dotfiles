function mtd -d "Make a temp directory and cd into it"
  set -l dir (mktemp -d)
  if test -n "$dir"
    if test -d "$dir"
      echo "$dir"
      cd "$dir"
    else
      echo "mktemp directory $dir does not exist"
    end
  else
    echo "mktemp didn't work"
  end
end
