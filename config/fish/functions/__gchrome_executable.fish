function __gchrome_executable
  if not set -q __gchrome_executable
    if test -f "/usr/bin/google-chrome"
      set __gchrome_executable "/usr/bin/google-chrome"
    else if test -f "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
      set __gchrome_executable "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    else
      echo "Can't find Chrome executable" >&2
      return 1
    end
  end
  echo $__gchrome_executable
end
