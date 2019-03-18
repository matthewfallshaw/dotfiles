function reverse --description 'Reverse a list'
  set output
  for i in $argv
    set output $i $output
  end
  for i in $output
    echo $i
  end
end
