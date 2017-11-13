# cd up n directories
cdup() {
  local ups
  ups="";
  for i in $(seq 1 $1); do
    ups=$ups"../";
  done
  cd $ups
}

# .. cds to parent, therefore ..., ...., ....., etc.
dots="."
for i in $(seq 1 9); do
  dots=$dots"."
  alias $dots="cdup $i"
done

return 0
