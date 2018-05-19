function! Py2()
  let g:syntastic_python_python_exec = '/usr/local/bin/python2.7'
endfunction
function! Py3()
  let g:syntastic_python_python_exec = '/usr/local/bin/python3.6'
endfunction
call Py3()   " default to Py3 because I try to use it when possible

" call SyntaxRange#Include( '^\s*sql[0-9]? = """\s*$', '^\s*"""\s*$', 'sql')
