set SEP 'SHUQUAOZ6EIYUO4KAHTH'  # a presumed unique key

if test -d "$HOME/.config/google-chrome"
  set __gchrome_base_dir "$HOME/.config/google-chrome"
else
  set __gchrome_base_dir "$HOME/Library/Application Support/Google/Chrome"
end

function __gchrome_get_profiles
  jq -r '[.profile.info_cache | to_entries[] | {"key": .key, "value": .value.name}] | .[] | "\(.value|@sh)'$SEP'\(.key|@sh)"' "$__gchrome_base_dir/Local State"
end

function __gchrome_get_profile_from_pair
  set -l k_v (string split $SEP $argv[1])
  echo $k_v[2]
end

function __gchrome_get_profile_alias_from_pair
  set -l k_v (string split $SEP $argv[1])
  echo $k_v[1]
end

function __gchrome_get_profile_from_alias
  for profile_pair in (__gchrome_get_profiles)
    set -l quoted_alias (__gchrome_get_profile_alias_from_pair $profile_pair)
    set -l alias (string trim -c "'" $quoted_alias)
    if [ $argv[1] = $alias ]
      set -l quoted_profile (__gchrome_get_profile_from_pair $profile_pair)
      set -l profile (string trim -c "'" $quoted_profile)
      echo $profile
      break
    end
  end
end

function __gchrome_get_completions
  for profile in (__gchrome_get_profiles)
    echo (__gchrome_get_profile_alias_from_pair $profile)
  end
end

set -l completions (string join ' ' (__gchrome_get_completions))
complete --no-files --command gchrome --condition "not __fish_seen_subcommand_from $completions" --keep-order --arguments $completions
