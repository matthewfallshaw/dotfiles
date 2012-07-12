# ~/.bashrc: executed by bash(1) for non-login shells.

system_name=`uname -s`


# set PATH so it includes .cabal bin if it exists
[ -d ~/.cabal/bin ] && export PATH=~/.cabal/bin:"${PATH}"

# set PATH so it includes /usr/local/bin and sbin early if they exist
[ -d /usr/local/sbin ] && export PATH=/usr/local/sbin:"${PATH}"
[ -d /usr/local/bin ] && export PATH=/usr/local/bin:"${PATH}"

# set PATH so it includes user's private bin if it exists
[ -d ~/bin ] && export PATH=~/bin:"${PATH}"

# Ruby version manager
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

# Node version manager
NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && source $NVM_DIR/nvm.sh

# AWS credentials
[ -a "$HOME/.aws/bashrc" ] && source "$HOME/.aws/bashrc"

# remove duplicates from PATH
export PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`


# don't put duplicate lines or lines starting with a space (good for sensitive info) in the history.
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=100000
# share history between terms
shopt -s histappend
PROMPT_COMMAND='history -a'


shopt -s cdspell
shopt -s cmdhist


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
if [ "$system_name" == 'Darwin' ]; then
  [ -z $DISPLAY ] && export DISPLAY=:0
fi


[ -z $EDITOR ] && export EDITOR=vim
[ -z $GREP_OPTIONS ] && export GREP_OPTIONS="--color=auto"
[ -z $LESS ] && export LESS="--RAW-CONTROL-CHARS"
[ -z $REPLYTO ] && export REPLYTO=youremailaddress


# bash completion
if [ -f `/usr/local/bin/brew --prefix`/etc/bash_completion ]; then  # homebrew bash-completion
  . `/usr/local/bin/brew --prefix`/etc/bash_completion
elif [ -f /opt/local/etc/bash_completion ]; then  # macports port bash-completion
  . /opt/local/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
# custom completions
for i in ~/.utils/bash_completion.d/*; do
  . $i
done
unset i


# rvm in prompt
function rvm_current {
  if [ -f .rvmrc ]; then echo "($(rvm-prompt i v g s))"; fi
}

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
  ;;
*)
  ;;
esac
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | xterm-256color)
  yellow="\[\e[0;33m\]"
  green="\[\e[0;32m\]"
  red="\[\e[0;31m\]"
  blue="\[\e[0;34m\]"
  fgcolor="\[\e[0m\]"
  export PS1="${yellow}\u@\h${fgcolor}:${blue}\w${fgcolor}\$(__git_ps1 \" (%s)\")\$(rvm_current)$ "
  unset yellow green red blue fgcolor
  ;;
*)
  PS1="\u@\h:\w\$(__git_ps1 \" (%s)\")\$(rvm_current)$ "
  ;;
esac

# mpd config
export MPD_HOST=mpd
export MPD_PORT=6600

# Autotest
export AUTOFEATURE=true
export RSPEC=true

# Autojump
if [ -f `/usr/local/bin/brew --prefix`/etc/autojump ]; then
  . `/usr/local/bin/brew --prefix`/etc/autojump
fi

# Alias definitions.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# set PATH so it includes homebrew coreutils if they exists
if [ -d "$(brew --prefix coreutils)/libexec/gnubin" ] ; then
  export PATH="$(brew --prefix coreutils)/libexec/gnubin:${PATH}"
fi
