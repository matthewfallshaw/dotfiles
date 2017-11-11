# ~/.bashrc: executed by bash(1) for non-login shells.

system_name=`uname -s`


# set PATH so it includes /usr/local/bin and sbin early if they exist
[ -d /usr/local/sbin ] && export PATH=/usr/local/sbin:"${PATH}"
[ -d /usr/local/bin ] && export PATH=/usr/local/bin:"${PATH}"
[ -d /usr/local/bin ] && export MANPATH=/usr/local/man:"${MANPATH}"

[ -d /usr/share/man ] && export MANPATH=/usr/share/man:"${MANPATH}"

# set PATH so it includes user's private bin if it exists
[ -d ~/bin ] && export PATH=~/bin:"${PATH}"

# set PATH so it includes homebrew coreutils and findutils if they exist
if [ -d "$(brew --prefix coreutils)/libexec/gnubin" ] ; then
  export PATH="$(brew --prefix coreutils)/libexec/gnubin:${PATH}"
  export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
fi
if [ -d "$(brew --prefix findutils)/libexec/gnubin" ] ; then
  export PATH="$(brew --prefix findutils)/libexec/gnubin:${PATH}"
  export MANPATH="$(brew --prefix findutils)/libexec/gnuman:$MANPATH"
fi

# AWS credentials
[ -a "$HOME/.aws/bashrc" ] && source "$HOME/.aws/bashrc"

# rbenv
eval "$(rbenv init -)"

# remove duplicates from PATH
export PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`


# don't put duplicate lines or lines starting with a space (good for sensitive info) in the history.
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000
# share history between terms
shopt -s histappend
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"


shopt -s cdspell
shopt -s cmdhist


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
if [ "$system_name" == 'Darwin' ]; then
  [ -z $DISPLAY ] && export DISPLAY=:0
fi


[ -z $EDITOR ] && export EDITOR=vim
#[ -z $GREP_OPTIONS ] && export GREP_OPTIONS="--color=auto"
[ -z $LESS ] && export LESS="--RAW-CONTROL-CHARS"
[ -z $REPLYTO ] && export REPLYTO=youremailaddress


# bash completion
if [ -f `/usr/local/bin/brew --prefix`/etc/bash_completion ]; then  # homebrew bash-completion
  . `/usr/local/bin/brew --prefix`/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
# custom completions
for i in ~/.utils/bash_completion.d/*; do
  . $i
done
unset i


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
  export PS1="${yellow}\u@\h${fgcolor}:${blue}\w${fgcolor}\$(__git_ps1 \" (%s)\")$ "
  unset yellow green red blue fgcolor
  ;;
*)
  PS1="\u@\h:\w\$(__git_ps1 \" (%s)\")$ "
  ;;
esac

# Autotest
export AUTOFEATURE=true
export RSPEC=true

# Autojump
if [ -f `/usr/local/bin/brew --prefix`/etc/profile.d/autojump.sh ]; then
  . `/usr/local/bin/brew --prefix`/etc/profile.d/autojump.sh
fi

# Alias definitions.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
