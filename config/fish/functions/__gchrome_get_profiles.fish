function __gchrome_get_profiles
  set -l __gchrome_base_dir (__gchrome_base_dir)
  jq -r '[.profile.info_cache | to_entries[] | {"key": .key, "value": .value.name}] | .[] | "\(.value|@sh)\t\(.key|@sh)"' "$__gchrome_base_dir/Local State"
end
