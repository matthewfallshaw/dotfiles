" Close {} or do; end on <TAB><CR>
if !exists( "*EndToken" )
  function EndToken()
    let current_line = getline( '.' )
    let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
    if match( current_line, braces_at_end ) >= 0
      return '}'
    else
      return 'end'
    endif
  endfunction
endif
"imap <TAB><CR>    <ESC>:execute 'normal o' . EndToken()<CR>O

imap <<-    <<-QUOTE<CR><Tab><CR>QUOTE<Esc>-A
