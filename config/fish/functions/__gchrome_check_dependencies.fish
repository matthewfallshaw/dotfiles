function __gchrome_check_dependencies
  if not which -s jq
    echo "gchrome: google-chrome profile launcher
    Missing dependency: `jq` not found. (`jq` is a lightweight and flexible command-line JSON processor.)
    Install it with something like:
      `brew install jq`
        or
      `sudo apt-get install jq`"
    return 1
  end
end
