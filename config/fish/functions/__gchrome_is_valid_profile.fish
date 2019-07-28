function __gchrome_is_valid_profile
  set -l __gchrome_base_dir (__gchrome_base_dir)
  set -l profile_path "$__gchrome_base_dir/$argv[1]"
  [ -n "$argv[1]" ] &&
    [ -d (readlink -f "$profile_path") ] &&
    [ -f (readlink -f "$profile_path/Cookies") ]
end
