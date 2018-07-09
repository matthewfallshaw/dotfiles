# PATH & MANPATH
# see zshenv
paths=(
  /sbin
  /usr/sbin
  /bin
  /usr/bin
  /usr/local/sbin
  /usr/local/bin
  /usr/X11/bin
  /usr/local/opt/coreutils/libexec/gnubin
  /usr/local/opt/findutils/libexec/gnubin
  ~/bin
)
for i in $paths; do
  [ -d "$i" ] && export PATH="$i":"${PATH}"
done
typeset -U path PATH

manpaths=(
  /usr/share/man
  /usr/local/share/man
  /usr/local/man
  /usr/X11/share/man
  /usr/local/opt/coreutils/libexec/gnuman
  /usr/local/opt/findutils/libexec/gnuman
)
[[ -v MANPATH ]] && MANPATH=/opt/X11/share/man  # avoid trailing : if MANPATH undefined
for i in $manpaths; do
  [ -d "$i" ] && export MANPATH="$i":"${MANPATH}"
done
typeset -U manpath MANPATH
