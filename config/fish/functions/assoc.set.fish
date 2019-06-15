set __separator \31 # ASCII Unit separator

function assoc.set -S -a varspec -a value -d "Add/update a value"
  assoc._parsename $varspec; or return $status

  if set -l idx (assoc.has_key $varspec)
    if [ -z $value ]
      set -e $_map_varname"[$idx]"
      return 0
      else
        set $_map_varname"[$idx]" $_map_key$__separator$value
        return 0
      end
  else
    set $_map_varname $$_map_varname $_map_key$__separator$value
    return 0
  end
end
