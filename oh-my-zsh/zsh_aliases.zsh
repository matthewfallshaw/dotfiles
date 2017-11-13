# Some useful aliases
alias aliases='echo "waiting for Vim to close…"; vim -f ~/.oh-my-zsh/custom/zsh_aliases.zsh && source ~/.oh-my-zsh/custom/zsh_aliases.zsh'

#########################################
# default options for standard commands #
#########################################
alias ls='ls -h'
alias which='which -a'


#######
# git #
#######
alias g='git'
alias ga='git add'
alias gb='git branch --verbose'
alias gba='git branch --verbose -a'
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gd='git diff --ignore-space-change'
alias gl='git pull'
alias gm='git merge'
alias gnp='git --no-pager'
alias gp='git push'
alias gs='git stash'
alias gst='git status'
alias gsu='git submodule update'
alias gsui='git submodule update --init'

alias st='git status'

function gco {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $1
  fi
}

# Gitx.app (http://rowanj.github.io/gitx/)
alias gx="gitx"
alias gxc="gitx --commit"
alias gxd="git diff --ignore-space-change | gitx --diff"


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
alias lla='ls -alh --color=auto'

alias ql='qlmanage -p 2>/dev/null'
