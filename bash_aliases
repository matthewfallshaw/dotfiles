# Some useful aliases
# vi:filetype=sh:
alias aliases='vim ~/.bash_aliases && source ~/.bash_aliases'

#######
# git #
#######
alias g='git'
alias gb='git branch --verbose'
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gd='git diff --ignore-space-change'
alias gk='gitk &'
alias gl='git pull'
alias gp='git push'

function gco {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $1
  fi
}

function st {
  if [ -d ".svn" ]; then
    svn status
  else
    git status
  fi
}

#######
# SVN #
#######
alias sup='svn up' # trust me 3 chars makes a difference
alias svnclear='find . -name .svn -print0 | xargs -0 rm -rf' # removes all .svn folders from directory recursively
alias svnaddall='svn status | grep "^\?" | awk "{print \$2}" | xargs svn add' # adds all unadded files

########
# RUBY #
########
# use readline, completion and require rubygems by default for irb
alias irb='irb --simple-prompt -r irb/completion -rubygems'

export GEMDIR=`gem env gemdir`
# use: cdgem <gem name>, cd's into your gems directory and opens gem that best
# matches the gem name provided
function cdgem {
  cd $GEMDIR/gems
  cd `ls | grep $1 | sort | tail -1`
}
_cdgemcomplete() {
  COMPREPLY=($(compgen -W '$(ls $GEMDIR/gems)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}
complete -o default -o nospace -F _cdgemcomplete cdgem
# use: gemdoc <gem name>, opens gem docs from the gem docs directory that best
# matches the gem name provided
# (hat tip: http://stephencelis.com/archive/2008/6/bashfully-yours-gem-shortcuts)
gemdoc() {
  open -a firefox $GEMDIR/doc/`ls $GEMDIR/doc | grep $1 | sort | tail -1`/rdoc/index.html
}
_gemdocomplete() {
  COMPREPLY=($(compgen -W '$(ls $GEMDIR/doc)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}
complete -o default -o nospace -F _gemdocomplete gemdoc

#########
# RAILS #
#########
alias ss='script/server' # start up the beast
alias sr='kill -USR2 `cat tmp/pids/mongrel.pid`' # restart detached Mongrel
alias sst='kill `cat tmp/pids/mongrel.pid`' # restart detached Mongrel
alias sc='script/console'
alias a='autotest -rails' # makes autotesting even quicker

#############
# PASSENGER #
#############
# Use this in any RAILS_ROOT dir. That restart.txt file tells mod_rails to restart this app.
# You'll want to do this when (for example) you install a new plugin.
alias passenger-restart='touch tmp/restart.txt'

# You'll be adding to your vhosts configuration everytime you introduce a new Rails app.
# Might as well make it a shortcut
alias passenger-host='sudo gvim -p ~/apache2/vhosts.conf /etc/hosts > /dev/null'

# You'll need to restart apache whenever you make a change to vhosts.
# You can also click System Preference->Sharing->Web Sharing, but this is quicker.
alias graceful='sudo apachectl graceful'

#########
# ~/dev #
#########
cdd() {
  cd ~/dev/$1
}
_cddcomplete() {
  COMPREPLY=($(compgen -W '$(ls ~/dev/)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}
complete -o default -o nospace -F _cddcomplete cdd


########
# misc #
########
alias h='history'
alias j="jobs -l"
alias l="ls -lah"
alias ls='ls --color=auto'
alias ll="ls -l --color=auto"
alias la='ls -A --color=auto'
alias lla='ls -Al --color=auto'
alias svnst="svn st | grep -v '^\?'"
alias which='which -a'
alias cleanvimswaps="find . | grep \.sw[po]$ | xargs rm"
