set __separator \31 # ASCII Unit separator

function assoc.has_key -S -a varspec -d "Return 0 when contains subject, print index"
  assoc._parsename $varspec; or return $status

  # replace all following __separator in each element to show only keys
  contains -i $_map_key (string replace -ra $__assoc_US.+ '' $$_map_varname)
end
