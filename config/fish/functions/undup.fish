function undup --description 'Remove duplicates from a list'
  if test (count $argv) = 1
    set -l output
    for i in $$argv
      if not contains -- $i $output
        set output $output $i
      end
    end
    set $argv $output
  else
    for i in $argv
      undup $i
    end
  end
end
