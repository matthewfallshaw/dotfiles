function __gchrome_base_dir
  if not set -q __gchrome_base_dir
    if test -d "$HOME/.config/google-chrome"
      set __gchrome_base_dir "$HOME/.config/google-chrome"
    else
      set __gchrome_base_dir "$HOME/Library/Application Support/Google/Chrome"
    end
  end
  echo $__gchrome_base_dir
end
