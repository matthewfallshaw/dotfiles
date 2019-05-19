# google-chrome profile launcher
#
# Adaptation of various ideas and solutions mentioned in https://superuser.com/a/377195/28775
# This script is meant to be "sourced" into your bash-profile. It provides command 'gchrome'
# and provides auto-completion of the profile-name.
# Converted for fish from https://github.com/codemedic/bash-ninja/blob/master/gchrome

source (dirname (status --current-filename))/../completions/gchrome.fish

if test -f "/usr/bin/google-chrome"
  set _gchrome_executable "/usr/bin/google-chrome"
else
  set _gchrome_executable "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
end

function _gchrome_check_dependencies
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

function _gchrome_is_valid_profile
  set -l profile_path "$_gchrome_base_dir/$argv[1]"
  [ -n "$argv[1]" ] &&
    [ -d (readlink -f "$profile_path") ] &&
    [ -f (readlink -f "$profile_path/Cookies") ]
end

function _gchrome_is_valid_profile_alias
  if [ -z $argv[1] ]; return 1; end

  set -l profile (_gchrome_get_profile_from_alias $argv[1])
  _gchrome_is_valid_profile $profile && return 0 || return 1
end

function _gchrome_get_last_used_profile
  jq -r '.profile.last_used' "$_gchrome_base_dir/Local State"
end

function _gchrome
  _gchrome_check_dependencies || return 1

  set -l opts
  if _gchrome_is_valid_profile "$argv[1]"
    set --append opts "--profile-directory=$argv[1]"
    set --erase argv[1]
  else if _gchrome_is_valid_profile_alias $argv[1]
    set --append opts "--profile-directory="(_gchrome_get_profile_from_alias $argv[1])
    set --erase argv[1]
  end

  $_gchrome_executable $opts "$argv" >/dev/null 2>&1
end

function gchrome -d "Launch a new Google Chrome window from specified Profile"
  if _gchrome_is_valid_profile $argv[1] || _gchrome_is_valid_profile_alias $argv[1]
    _gchrome "$argv"
  else
    _gchrome "$_gchrome_get_last_used_profile" "$argv"
  end
end
