function __complete_cds --description 'Completions for the cds command'
  set -l token (commandline -ct)
  set -l cdpath "$HOME/source"

  # This assumes the CDPATH component itself is cd-able
  for d in $cdpath/$token*/
    # Remove the cdpath component again
    [ -x $d ]
    and printf "%s\n" (string replace -r "^$cdpath/" "" -- $d)
  end
end
complete -x -c cds -a "(__complete_cds)"
