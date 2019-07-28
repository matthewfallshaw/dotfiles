# google-chrome profile launcher
#
# Adaptation of various ideas and solutions mentioned in https://superuser.com/a/377195/28775
# Converted for fish from https://github.com/codemedic/bash-ninja/blob/master/gchrome

source $__fish_config_dir/completions/gchrome.fish

function gchrome -d "Launch a new Google Chrome window from specified Profile"
  __gchrome_check_dependencies || return 1

  if ! __gchrome_is_valid_profile $argv[1] && ! __gchrome_is_valid_profile_alias $argv[1]
    set --prepend argv "$__gchrome_get_last_used_profile"
  end

  set -l opts --new-window
  if __gchrome_is_valid_profile "$argv[1]"
    set --append opts "--profile-directory=$argv[1]"
    set --erase argv[1]
  else if __gchrome_is_valid_profile_alias $argv[1]
    set --append opts "--profile-directory="(__gchrome_get_profile_from_alias $argv[1])
    set --erase argv[1]
  end

  set -l __gchrome_executable (__gchrome_executable)
  $__gchrome_executable $opts "$argv" >/dev/null 2>&1
end
