set __separator \31 # ASCII Unit separator

function assoc.rm -S -a varspec -d "Remove where key matches"
  assoc._parsename $varspec; or return $status

  if set -l idx (assoc.has_key $varspec)
    set -e $_map_varname"[$idx]"
  end
end
