set fish_greeting  # nohello

# paths
## PATH
set -gq PATH || set -gx PATH ''
for d in (reverse /Users/matt/bin /Users/matt/code/clipboard-scripts/bin /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin /Users/matt/.rbenv/shims /usr/local/opt/sqlite/bin /usr/local/opt/fzf/bin /usr/local/MacGPG2/bin /opt/puppetlabs/bin /usr/local/opt/findutils/libexec/gnubin /usr/local/opt/coreutils/libexec/gnubin /usr/local/bin /usr/local/sbin /opt/X11/bin /usr/bin /usr/sbin /bin /sbin)
  set -gx PATH $d $PATH
end

## MANPATH
set -gq MANPATH || set -gx MANPATH ''
for d in (reverse /usr/local/opt/findutils/libexec/gnuman /usr/local/opt/coreutils/libexec/gnuman /usr/local/MacGPG2/share/man /opt/X11/share/man /usr/local/share/man /usr/local/man /usr/share/man)
  set -gx MANPATH $d $MANPATH
end

# google-cloud-sdk completion & path
for p in /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/{completion.fish.inc,path.fish.inc}
  test -e $p; and source $p
end

# msmtp
set -gx MAIL_SERVER smtp.gmail.com
set -gx MAIL_PORT 587
set -gx MAIL_USE_TLS True
set -gx MAIL_USE_SSL False
set -gx MAIL_USERNAME (security find-generic-password -a dotfiles -s msmtp.email -w)
set -gx MAIL_PASSWORD (security find-generic-password -a dotfiles -s msmtp.pass -w)

# fisher
if not functions -q fisher
  echo "Installing fisher for the first time..." >&2
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fisher -c fisher
end

if test -n "$NVIM_LISTEN_ADDRESS"
	alias h "nvr -c 'doau BufEnter' -o"
	alias v "nvr -c 'doau BufEnter' -O"
	alias t "nvr -c 'doau BufEnter' --remote-tab"
	alias o "nvr -c 'doau BufEnter'"
	alias neovim 'command nvim'
	alias nvim "echo 'You\'re already in nvim. Consider using o, h, v, or t instead. Use \'neovim\' to force.'"
else
  alias o 'nvim'
end
set -gx EDITOR 'nvim'
set -gx SUDO_EDITOR nvim

function fish_prompt
  powerline-shell --shell bare $status
end

# Aliases
source ~/.config/fish/aliases.fish

# iTerm integration
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

# Bindings
bind $argv \cx\ce edit_command_buffer
