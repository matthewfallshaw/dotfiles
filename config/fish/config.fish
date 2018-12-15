set fish_greeting  # nohello

# set
set -gx EDITOR vim
test -d /usr/local/opt/findutils/libexec/gnubin; and set -gx PATH /usr/local/opt/findutils/libexec/gnubin $PATH
test -d /usr/local/opt/findutils/libexec/gnuman; and set -gx MANPATH /usr/local/opt/findutils/libexec/gnuman $MANPATH
test -d /usr/local/opt/coreutils/libexec/gnubin; and set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
test -d /usr/local/opt/coreutils/libexec/gnuman; and set -gx MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
test -d /usr/local/sbin; and set -gx PATH /usr/local/sbin $PATH
test -d /usr/local/bin; and set -gx PATH /usr/local/bin $PATH
test -d /usr/local/man; and set -gx MANPATH /usr/local/man $MANPATH
test -d /usr/share/man; and set -gx MANPATH /usr/share/man $MANPATH
test -d ~/bin; and set -gx PATH ~/bin $PATH

set -g fish_user_paths "/usr/local/opt/sqlite/bin" $fish_user_paths
for p in /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/{completion.fish.inc,path.fish.inc}
  test -e $p; and source $p
end

if not functions -q fisher
    echo "Installing fisher for the first time..." >&2
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fisher
end

function fish_prompt
  powerline-shell --shell bare $status
end

# Aliases
source ~/.config/fish/aliases.fish

# iTerm integration
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

# undup PATH, MANPATH
undup PATH
undup MANPATH
