# ~/.bashrc: executed by bash(1) for non-login shells.

system_name=`uname -s`

if [ "$system_name" == 'Darwin' ]; then
  # set PATH so it includes ports
  export PATH=/opt/local/bin:/opt/local/sbin:"${PATH}"
fi
# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    export PATH=~/bin:"${PATH}"
fi
# remove duplicates from PATH
export PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`

# If not running interactively, don't do anything else
[ -z "$PS1" ] && return
######################################################

if [ -f ~/.terminal ]; then
  source ~/.terminal
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export CDPATH=.:~/dev:~/Desktop/projects
if [ "$system_name" == 'Darwin' ]; then
  # set MANPATH so it includes ports
  export MANPATH=/opt/local/share/man:"${MANPATH}"
fi

# don't put duplicate lines or lines starting with a space (good for sensitive info) in the history.
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=100000
# share history between terms
shopt -s histappend
PROMPT_COMMAND='history -a'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
if [ "$system_name" == 'Darwin' ]; then
  [ -z $DISPLAY ] && export DISPLAY=:0
fi

[ -z $EDITOR ] && export EDITOR=vim
[ -z $GREP_OPTIONS ] && export GREP_OPTIONS="--color=auto"
[ -z $LESS ] && export LESS="--RAW-CONTROL-CHARS"
[ -z $REPLYTO ] && export REPLYTO=emailaddress

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
  ;;
*)
  ;;
esac

# completion
if [ "$system_name" == 'Darwin' ]; then
  complete -C "ruby -r~/.utils/completion_rake_cap.rb -e 'puts complete_tasks(:rake)'" -o default rake
  function clear-completion-rake {
    rm ~/.raketabs-*
  }
  complete -C "ruby -r~/.utils/completion_rake_cap.rb -e 'puts complete_tasks(:cap)'" -o default cap
  function clear-completion-cap {
    rm ~/.captabs-*
  }
  source ~/.utils/completion_git.sh
  if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
  fi
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
  yellow="\[\e[0;33m\]"
  green="\[\e[0;32m\]"
  red="\[\e[0;31m\]"
  blue="\[\e[0;34m\]"
  fgcolor="\[\e[0m\]"
  #export PS1="${yellow}\h${fgcolor}:${green}\W${red}\$(__git_ps1)${fgcolor}\$ "
  export PS1="${yellow}\h${fgcolor}:${blue}\w${fgcolor} ${green}\u${fgcolor}\$(__git_ps1 \" (%s)\")$ "
  unset yellow green red blue fgcolor
  ;;
  *)
  PS1='\h:\w \u\$ '
  ;;
esac

if [ "$system_name" == 'Darwin' ]; then
  # mpd config
  export MPD_HOST=mpd
  export MPD_PORT=6600
fi
