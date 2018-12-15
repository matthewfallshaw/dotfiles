# Some useful aliases
alias aliases="echo 'waiting for nim to close…'; nvim -f "(status --current-filename)"; and source "(status --current-filename)

#########################################
# default options for standard commands #
#########################################
alias ls='ls -h'
alias which='which -a'


#######
# git #
#######
alias git='hub'
alias g='git'
alias ga="git add"
alias gb='git branch --verbose'
alias gba='git branch --verbose -a'
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gd='git diff --ignore-space-change $argv'
alias gl='git pull'
alias gm="git merge"
alias gnp='git --no-pager'
alias gp='git push'
alias gs="git stash"
alias gst='git status'
alias gsu="git submodule update"
alias gsui="git submodule update --init"
alias gst="git status"
alias st="echo -e \"\a####\nuse `gst`\n####\n\"; git status"

# Gitx.app (http://rowanj.github.io/gitx/)
alias gx="gitx"
alias gxc="gitx --commit"
alias gxd="git diff --ignore-space-change | gitx --diff"
# Gitup.app (https://github.com/git-up/GitUp)
alias gu='gitup commit'
alias guc='gitup commit'
alias gum='gitup map'
alias gus='gitup stash'


########
# RUBY #
########
# use readline, completion and require rubygems by default for irb
alias irb='irb --simple-prompt -r irb/completion -rubygems'
alias rtags='ctags -R --languages=ruby --exclude=.git --exclude=log .'

# Rails
alias ss='script/server' # start up the beast
alias sc='script/console'

# You'll need to restart apache whenever you make a change to vhosts.
# You can also click System Preference->Sharing->Web Sharing, but this is quicker.
alias graceful='sudo apachectl graceful'


########
# misc #
########
alias h='history'

alias l="ls -lah"
alias la='ls -ah --color=auto'
alias ll="ls -lh --color=auto"
alias lla='ls -alh --color=auto'

alias ql='qlmanage -p 2>/dev/null'
alias j='z'

# .. cds to parent, therefore ..., ...., ....., etc.
set -l dots "."
for i in (seq 1 9)
  set dots $dots"."
  alias $dots="cdup $i"
end
