# Some useful aliases
alias aliases='echo "waiting for MacVim to close…"; mvim -f ~/.bash_aliases; and source ~/.config/fish/aliases.fish'

#########################################
# default options for standard commands #
#########################################
alias ls='ls -h'
alias pwsafe='pwsafe -E'
alias which='which -a'


#######
# git #
#######
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

alias st='git status'

function gco
  if [ -z "$argv[1]" ]; then
    git checkout master
  else
    git checkout $argv[1]
  end
end

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


# Tensorflow
alias tf='cd ~/code/tensorflow; source bin/activate'
alias tfq='deactivate'

