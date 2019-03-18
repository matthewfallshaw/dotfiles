# ~/.bashrc: executed by bash(1) for non-login shells.

system_name=`uname -s`

pathadd() {
  for d; do
    if [ -z "$d" ]; then continue; fi  # skip nonexistent directory
    case ":${PATH:=$d}:" in
      *:$d:*) ;;
      *) PATH="$d:$PATH" ;;
    esac
  done
}
manpathadd() {
  for d; do
    if [ -z "$d" ]; then continue; fi  # skip nonexistent directory
    case ":${MANPATH:=$d}:" in
      *:$d:*) ;;
      *) MANPATH="$d:$MANPATH" ;;
    esac
  done
}

manpathadd /usr/share/man
# set PATH so it includes /usr/local/bin and sbin early if they exist
pathadd /usr/local/sbin
pathadd /usr/local/bin
manpath add /usr/local/man
manpath add /usr/share/man

# set PATH so it includes homebrew coreutils and findutils if they exist
pathadd /usr/local/opt/coreutils/libexec/gnubin
manpathadd /usr/local/opt/coreutils/libexec/gnuman
pathadd /usr/local/opt/findutils/libexec/gnubin
manpathadd /usr/local/opt/findutils/libexec/gnuman

# AWS credentials
[ -a "$HOME/.aws/bashrc" ] && source "$HOME/.aws/bashrc"

# rbenv
eval "$(rbenv init -)"

# set PATH so it includes user's private bin if it exists
[ -d ~/bin ] && export PATH=~/bin:"${PATH}"

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
[ -z $REPLYTO ] && export REPLYTO=`security find-generic-password -a dotfiles -s bashrc.replyto -w`


# bash completion
if [ -f /usr/local/etc/bash_completion ]; then  # homebrew bash-completion
  . /usr/local/etc/bash_completion
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
if [ -f /usr/local/etc/profile.d/autojump.sh ]; then
  . /usr/local/etc/profile.d/autojump.sh
fi

# For when you type the wrong thing
eval $(thefuck --alias)

# Z, jump around
[ -f /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

# Alias definitions.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
