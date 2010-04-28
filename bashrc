# ~/.bashrc: executed by bash(1) for non-login shells.

system_name=`uname -s`

if [ $system_name == 'Darwin' ]; then
  # set PATH so it includes ports
  export PATH=/opt/local/bin:/opt/local/sbin:"${PATH}"
fi
# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    export PATH=~/bin:"${PATH}"
fi
# remove duplicates from PATH
export PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`
