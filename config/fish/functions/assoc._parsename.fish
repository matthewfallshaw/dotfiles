set __separator \31 # ASCII Unit separator

function assoc._parsename -S -a raw -d "Groks name[key] and sets varname and key variables"
  set -l data (string match -r '(.+)\[(.+)\]' $raw)
  if [ (count $data) -lt 3 ]
    echo "Invalid assocatiave array specification '$raw'"
    return 1
  else 
    set _map_varname $data[2]
    set _map_key $data[3]
    return 0
  end
end
