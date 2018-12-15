function ls-aliases --description 'list all fish aliases'
	for f in (functions)
          functions $f | grep \'alias
      end
end
