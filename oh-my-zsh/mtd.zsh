# Make a temp directory and cd into it
mtd() {
  local dir
  dir=$(mktemp -d)
  if test -n "$dir"
  then
    if test -d "$dir"
    then
      echo "$dir"
      cd "$dir"
    else
      echo "mktemp directory $dir does not exist"
    fi
  else
    echo "mktemp didn't work"
  fi
}
