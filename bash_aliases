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
alias gd='git diff'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch -v'

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
alias sup='svn up' # trust me 3 chars makes a different
# alias sstu='svn st -u' # remote repository changes
# alias scom='svn commit' # commit
alias svnclear='find . -name .svn -print0 | xargs -0 rm -rf' # removes all .svn folders from directory recursively
alias svnaddall='svn status | grep "^\?" | awk "{print \$2}" | xargs svn add' # adds all unadded files

########
# RUBY #
########
# use readline, completion and require rubygems by default for irb
alias irb='irb --simple-prompt -r irb/completion -rubygems'

# really awesome function, use: cdgem <gem name>, cd's into your gems directory
# and opens gem that best matches the gem name provided
function cdgem {
  cd /opt/local/lib/ruby/gems/1.8/gems/
  cd `ls | grep $1 | sort | tail -1`
}
function gemdoc {
  firefox /opt/local/lib/ruby/gems/1.8/doc/`ls /opt/local/lib/ruby/gems/1.8/doc | grep $1 | sort | tail -1`/rdoc/index.html
}

#########
# RAILS #
#########
alias ss='script/server' # start up the beast
alias sr='kill -USR2 `cat tmp/pids/mongrel.pid`' # restart detached Mongrel
alias sst='kill `cat tmp/pids/mongrel.pid`' # restart detached Mongrel
alias sc='script/console'
alias a='autotest -rails' # makes autotesting even quicker

# see http://railstips.org/2007/5/31/even-edgier-than-edge-rails
function edgie() { 
  ruby ~/projects/rails/rails/railties/bin/rails $1 && cd $1 && ln -s ~/projects/rails/rails vendor/rails
}

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

# mysql from macports
alias mysql='/opt/local/bin/mysql5'
alias mysqlaccess='/opt/local/bin/mysqlaccess5'
alias mysql_client_test='/opt/local/bin/mysql_client_test5'
alias mysqladmin='/opt/local/bin/mysqladmin5'
alias mysql_config='/opt/local/bin/mysql_config5'
alias mysqlbinlog='/opt/local/bin/mysqlbinlog5'
alias mysql_convert_table_format='/opt/local/bin/mysql_convert_table_format5'
alias mysqlbug='/opt/local/bin/mysqlbug5'
alias mysql_explain_log='/opt/local/bin/mysql_explain_log5'
alias mysqlcheck='/opt/local/bin/mysqlcheck5'
alias mysql_find_rows='/opt/local/bin/mysql_find_rows5'
alias mysqld_multi='/opt/local/bin/mysqld_multi5'
alias mysql_fix_extensions='/opt/local/bin/mysql_fix_extensions5'
alias mysqld_safe='/opt/local/bin/mysqld_safe5'
alias mysql_fix_privilege_tables='/opt/local/bin/mysql_fix_privilege_tables5'
alias mysqldump='/opt/local/bin/mysqldump5'
alias mysql_install_db='/opt/local/bin/mysql_install_db5'
alias mysqldumpslow='/opt/local/bin/mysqldumpslow5'
alias mysql_secure_installation='/opt/local/bin/mysql_secure_installation5'
alias mysqlhotcopy='/opt/local/bin/mysqlhotcopy5'
alias mysql_setpermission='/opt/local/bin/mysql_setpermission5'
alias mysqlimport='/opt/local/bin/mysqlimport5'
alias mysql_tableinfo='/opt/local/bin/mysql_tableinfo5'
alias mysqlshow='/opt/local/bin/mysqlshow5'
alias mysql_tzinfo_to_sql='/opt/local/bin/mysql_tzinfo_to_sql5'
alias mysqltest='/opt/local/bin/mysqltest5'
alias mysql_upgrade='/opt/local/bin/mysql_upgrade5'
alias mysqltestmanager-pwgen='/opt/local/bin/mysqltestmanager-pwgen5'
alias mysql_upgrade_shell='/opt/local/bin/mysql_upgrade_shell5'
alias mysqltestmanager='/opt/local/bin/mysqltestmanager5'
alias mysql_waitpid='/opt/local/bin/mysql_waitpid5'
alias mysqltestmanagerc='/opt/local/bin/mysqltestmanagerc5'
alias mysql_zap='/opt/local/bin/mysql_zap5'
