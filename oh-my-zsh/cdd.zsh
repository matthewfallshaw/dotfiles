# cd into code dir
function cdd {
  if [ -z "$1" ]; then
    cd ~/code
  else
    cd ~/code/$1
  fi
}
compdef '_files -/ -W ~/code' cdd
