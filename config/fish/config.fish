# set
set -gx EDITOR vim
set -gx fish_key_bindings fish_vi_key_bindings
test -d /usr/local/opt/findutils/libexec/gnubin; and set -gx PATH /usr/local/opt/findutils/libexec/gnubin $PATH
test -d /usr/local/opt/findutils/libexec/gnuman; and set -gx MANPATH /usr/local/opt/findutils/libexec/gnuman $PATH
test -d /usr/local/opt/coreutils/libexec/gnubin; and set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
test -d /usr/local/opt/coreutils/libexec/gnuman; and set -gx MANPATH /usr/local/opt/coreutils/libexec/gnuman $PATH
test -d /usr/local/sbin; and set -gx PATH /usr/local/sbin $PATH
test -d /usr/local/bin; and set -gx PATH /usr/local/bin $PATH
test -d ~/bin; and set -gx PATH ~/bin $PATH
undup PATH

# Aliases
source ~/.config/fish/aliases.fish
