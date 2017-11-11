# set
set -gx EDITOR vim
set -gx fish_key_bindings fish_vi_key_bindings
test -d /usr/local/opt/findutils/libexec/gnubin; and set -gx PATH /usr/local/opt/findutils/libexec/gnubin $PATH
test -d /usr/local/opt/findutils/libexec/gnuman; and set -gx MANPATH /usr/local/opt/findutils/libexec/gnuman $MANPATH
test -d /usr/local/opt/coreutils/libexec/gnubin; and set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
test -d /usr/local/opt/coreutils/libexec/gnuman; and set -gx MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
test -d /usr/local/sbin; and set -gx PATH /usr/local/sbin $PATH
test -d /usr/local/bin; and set -gx PATH /usr/local/bin $PATH
test -d /usr/local/man; and set -gx MANPATH /usr/local/man $MANPATH
test -d /usr/share/man; and set -gx MANPATH /usr/share/man $MANPATH
test -d ~/bin; and set -gx PATH ~/bin $PATH
undup PATH
undup MANPATH

# Aliases
source ~/.config/fish/aliases.fish

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
