set SEP 'SHUQUAOZ6EIYUO4KAHTH'

if test -d "$HOME/.config/google-chrome"
  set _gchrome_base_dir "$HOME/.config/google-chrome"
else
  set _gchrome_base_dir "$HOME/Library/Application Support/Google/Chrome"
end

function _gchrome_get_profiles
  jq -r '[.profile.info_cache | to_entries[] | {"key": .key, "value": .value.name}] | .[] | "\(.value|@sh)'$SEP'\(.key|@sh)"' "$_gchrome_base_dir/Local State"
end

function _gchrome_get_profile_from_pair
  set -l k_v (string split $SEP $argv[1])
  echo $k_v[2]
end

function _gchrome_get_profile_alias_from_pair
  set -l k_v (string split $SEP $argv[1])
  echo $k_v[1]
end

function _gchrome_get_profile_from_alias
  for profile_pair in (_gchrome_get_profiles)
    set -l quoted_alias (_gchrome_get_profile_alias_from_pair $profile_pair)
    set -l alias (string trim -c "'" $quoted_alias)
    if [ $argv[1] = $alias ]
      set -l quoted_profile (_gchrome_get_profile_from_pair $profile_pair)
      set -l profile (string trim -c "'" $quoted_profile)
      echo $profile
      break
    end
  end
end

function _gchrome_get_completions
  for profile in (_gchrome_get_profiles)
    echo (_gchrome_get_profile_alias_from_pair $profile)
  end
end

set -l completions (string join ' ' (_gchrome_get_completions))
complete --no-files --command gchrome --condition "not __fish_seen_subcommand_from $completions" --keep-order --arguments $completions
