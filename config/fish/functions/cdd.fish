# cd into ~/code
function cdd
  if [ -z "$argv[1]" ]
    cd ~/code
  else
    cd ~/code/$argv[1]
  end
end
