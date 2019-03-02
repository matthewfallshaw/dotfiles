function undup --description 'Remove duplicates from a list'
  set -l output
  for i in $argv
    if not contains -- $i $output
      set output $output $i
    end
  end
  echo $output
end
