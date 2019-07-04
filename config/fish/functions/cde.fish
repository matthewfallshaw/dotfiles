function cde -d "cd into ~/eclipse-workspace"
  set -l cdpath "$HOME/eclipse-workspace"
  if [ -z "$argv[1]" ]
    cd $cdpath
  else
    cd $cdpath/$argv[1]
  end
end
