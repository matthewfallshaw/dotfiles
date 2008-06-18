# Some useful aliases
# vi:filetype=sh:
alias aliases='vim ~/.bash_aliases && source ~/.bash_aliases'

# Function which adds an alias to the current shell and to
# the ~/.bash_aliases file.
add-alias ()
{
   local name=$1 value="$2"
   echo "alias $name='$value'" >> ~/.bash_aliases
   eval "alias $name='$value'"
   alias $name
}

#######
# git #
#######
alias gl='git pull'
alias gp='git push'
alias gd='git diff --ignore-space-change'
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gb='git branch --verbose'
alias g='git'

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

# use: cdgem <gem name>, cd's into your gems directory and opens gem that best
# matches the gem name provided
function cdgem {
  cd /opt/local/lib/ruby/gems/1.8/gems/
  cd `ls | grep $1 | sort | tail -1`
}
# use: gemdoc <gem name>, opens gem docs from the gem docs directory that best
# matches the gem name provided
function gemdoc {
  open -a firefox /opt/local/lib/ruby/gems/1.8/doc/`ls /opt/local/lib/ruby/gems/1.8/doc | grep $1 | sort | tail -1`/rdoc/index.html
}

#########
# RAILS #
#########
alias ss='script/server' # start up the beast
alias sr='kill -USR2 `cat tmp/pids/mongrel.pid`' # restart detached Mongrel
alias sst='kill `cat tmp/pids/mongrel.pid`' # restart detached Mongrel
alias sc='script/console'
alias a='autotest -rails' # makes autotesting even quicker

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
