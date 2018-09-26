# Some useful aliases
alias aliases='echo "waiting for Vim to close…"; vim -f ~/.oh-my-zsh/custom/zsh_aliases.zsh && source ~/.oh-my-zsh/custom/zsh_aliases.zsh'

#########################################
# default options for standard commands #
#########################################
alias ls='ls -h --color=auto'
alias which='which -a'


#######
# git #
#######
alias git=hub
alias g='hub'
alias ga='hub add'
alias gb='hub branch --verbose'
alias gba='hub branch --verbose -a'
alias gc='hub commit --verbose'
alias gca='hub commit --verbose --all'
alias gd='hub diff --ignore-space-change'
alias gl='hub pull'
alias gm='hub merge'
alias gnp='hub --no-pager'
alias gp='hub push'
alias gs='hub stash'
alias gst='hub status'
alias gsu='hub submodule update'
alias gsui='hub submodule update --init'

alias st='hub status'

function gco {
  if [ -z "$1" ]; then
    hub checkout master
  else
    hub checkout $1
  fi
}

# Gitx.app (http://rowanj.github.io/gitx/)
alias gx="gitx"
alias gxc="gitx --commit"
alias gxd="hub diff --ignore-space-change | gitx --diff"


########
# RUBY #
########
# use readline, completion and require rubygems by default for irb
alias irb='irb --simple-prompt -r irb/completion -rubygems'
alias rtags='ctags -R --languages=ruby --exclude=.git --exclude=log .'


##############
# TENSORFLOW #
##############
alias tf='cd ~/code/tensorflow; source bin/activate'
alias tfq='deactivate'


########
# misc #
########
alias cleanvimswaps="find . -iregex '.*\.sw[po]$' -delete"
alias h='history'
alias l="ls -lah"
alias la='ls -ah --color=auto'
alias ll="ls -lh --color=auto"
alias lla='ls -lah --color=auto'

alias ql='qlmanage -p 2>/dev/null'
