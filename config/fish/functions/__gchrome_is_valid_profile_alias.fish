function __gchrome_is_valid_profile_alias
  if [ -z $argv[1] ]; return 1; end

  set -l profile (__gchrome_get_profile_from_alias $argv[1])
  __gchrome_is_valid_profile $profile && return 0 || return 1
end
