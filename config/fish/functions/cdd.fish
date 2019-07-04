function cdd -d "cd into ~/code"
  set -l cdpath "$HOME/code"
  if [ -z "$argv[1]" ]
    cd $cdpath
  else
    cd $cdpath/$argv[1]
  end
end
