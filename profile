# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.

export DOTPROFILE=1

# the default umask is set in /etc/login.defs
#umask 022

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# vi:filetype=sh:
