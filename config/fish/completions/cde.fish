function __complete_cde --description 'Completions for the cde command'
  set -l token (commandline -ct)
  set -l cdpath "$HOME/eclipse-workspace"

  # This assumes the CDPATH component itself is cd-able
  for d in $cdpath/$token*/
    # Remove the cdpath component again
    [ -x $d ]
    and printf "%s\n" (string replace -r "^$cdpath/" "" -- $d)
  end
end
complete -x -c cde -a "(__complete_cde)"
