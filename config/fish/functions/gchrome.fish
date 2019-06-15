# google-chrome profile launcher
#
# Adaptation of various ideas and solutions mentioned in https://superuser.com/a/377195/28775
# This script is meant to be "sourced" into your bash-profile. It provides command 'gchrome'
# and provides auto-completion of the profile-name.
# Converted for fish from https://github.com/codemedic/bash-ninja/blob/master/gchrome

source $__fish_config_dir/completions/gchrome.fish

if test -f "/usr/bin/google-chrome"
  set __gchrome_executable "/usr/bin/google-chrome"
else
  set __gchrome_executable "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
end

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

function __gchrome_is_valid_profile
  set -l profile_path "$__gchrome_base_dir/$argv[1]"
  [ -n "$argv[1]" ] &&
    [ -d (readlink -f "$profile_path") ] &&
    [ -f (readlink -f "$profile_path/Cookies") ]
end

function __gchrome_is_valid_profile_alias
  if [ -z $argv[1] ]; return 1; end

  set -l profile (__gchrome_get_profile_from_alias $argv[1])
  __gchrome_is_valid_profile $profile && return 0 || return 1
end

function __gchrome_get_last_used_profile
  jq -r '.profile.last_used' "$__gchrome_base_dir/Local State"
end

function __gchrome
  __gchrome_check_dependencies || return 1

  set -l opts
  if __gchrome_is_valid_profile "$argv[1]"
    set --append opts "--profile-directory=$argv[1]"
    set --erase argv[1]
  else if __gchrome_is_valid_profile_alias $argv[1]
    set --append opts "--profile-directory="(__gchrome_get_profile_from_alias $argv[1])
    set --erase argv[1]
  end

  $__gchrome_executable $opts "$argv" >/dev/null 2>&1
end

function gchrome -d "Launch a new Google Chrome window from specified Profile"
  if __gchrome_is_valid_profile $argv[1] || __gchrome_is_valid_profile_alias $argv[1]
    __gchrome "$argv"
  else
    __gchrome "$__gchrome_get_last_used_profile" "$argv"
  end
end
