# cd into ~/source
function cds
  set -l cdpath "$HOME/source"
  if [ -z "$argv[1]" ]
    cd $cdpath
  else
    cd $cdpath/$argv[1]
  end
end
