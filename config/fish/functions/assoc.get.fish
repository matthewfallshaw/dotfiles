set __separator \31 # ASCII Unit separator

function assoc.get -S -a varspec -d "Get a value for the given key"
  assoc._parsename $varspec; or return $status

  if set -l idx (assoc.has_key $varspec)
    eval string replace -r .+$__separator "''" '$'$_map_varname'['$idx']'
    return 0
  else
    return 1
  end
end
