# cd into ~/source
function cds
  if [ -z "$argv[1]" ]
    cd ~/source
  else
    cd ~/source/$argv[1]
  end
end
