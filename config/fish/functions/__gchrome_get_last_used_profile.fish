function __gchrome_get_last_used_profile
  set -l __gchrome_base_dir (__gchrome_base_dir)
  jq -r '.profile.last_used' "$__gchrome_base_dir/Local State"
end
