# ~/.bashrc: executed by bash(1) for non-login shells.

system_name=`uname -s`

if [ $system_name == 'Darwin' ]; then
  # set PATH so it includes ports
  export PATH=/opt/local/bin:/opt/local/sbin:"${PATH}"
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then export PATH=~/bin:"${PATH}" ; fi

# set PATH so it includes .cabal bin if it exists
if [ -d ~/.cabal/bin ] ; then export PATH=~/.cabal/bin:"${PATH}" ; fi

# remove duplicates from PATH
export PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`

# Ruby version manager
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then source "$HOME/.rvm/scripts/rvm" ; fi

# Node version manager
NVM_DIR=$HOME/.nvm
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . $NVM_DIR/nvm.sh
  nvm use
fi
