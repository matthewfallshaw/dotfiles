# cd into ~/code
function cdd
  set -l cdpath "$HOME/code"
  if [ -z "$argv[1]" ]
    cd $cdpath
  else
    cd $cdpath/$argv[1]
  end
end
