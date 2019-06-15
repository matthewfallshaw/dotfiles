set __separator \31 # ASCII Unit separator

function assoc.serialize -S -a varname
  printf '%s\n' $$varname
end
