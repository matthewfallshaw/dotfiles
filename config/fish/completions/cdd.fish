function __complete_cdd --description 'Completions for the cdd command'
  set -l token (commandline -ct)
  set -l cdpath "$HOME/code"

  # This assumes the CDPATH component itself is cd-able
  for d in $cdpath/$token*/
    # Remove the cdpath component again
    [ -x $d ]
    and printf "%s\n" (string replace -r "^$cdpath/" "" -- $d)
  end
end
complete -x -c cdd -a "(__complete_cdd)"
