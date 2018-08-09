# cd into source dir
function cds {
  if [ -z "$1" ]; then
    cd ~/source
  else
    cd ~/source/$1
  fi
}
compdef '_files -/ -W ~/source' cds
