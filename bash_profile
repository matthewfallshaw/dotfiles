[ -f ~/.bashrc ] && . ~/.bashrc

if [ -f ~/.terminal ]; then
  source ~/.terminal
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#if [ "$system_name" == 'Darwin' ]; then
#  # set MANPATH so it includes ports
#  export MANPATH=/opt/local/share/man:"${MANPATH}"
#fi

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
[ -z $REPLYTO ] && export REPLYTO=youremailaddress

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
  ;;
*)
  ;;
esac

# bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then  # homebrew bash-completion
  . `brew --prefix`/etc/bash_completion
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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
  yellow="\[\e[0;33m\]"
  green="\[\e[0;32m\]"
  red="\[\e[0;31m\]"
  blue="\[\e[0;34m\]"
  fgcolor="\[\e[0m\]"
  export PS1="${yellow}\u@\h${fgcolor}:${blue}\w${fgcolor}\$(__git_ps1 \" (%s)\")$ "
  unset yellow green red blue fgcolor
  ;;
  *)
  PS1='\u@\h:\w\$ '
  ;;
esac

# mpd config
export MPD_HOST=mpd
export MPD_PORT=6600

# Autotest
export AUTOFEATURE=true
export RSPEC=true

# OSX specific config
#if [ "$system_name" == 'Darwin' ]; then

#fi

# vi:filetype=sh
