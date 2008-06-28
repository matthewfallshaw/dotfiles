set nocompatible      " We're running Vim, not Vi
set encoding=utf8 nobomb " BOM often causes trouble
set visualbell        " must turn visual bell on to remove audio bell
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugin
behave xterm
set linebreak                 " when wrapping, try to break at characters in breakat
set breakat=\ ^I!@*-+;:,./?   " when wrapping, break at these characters
set showbreak=>               " character to show that a line is wrapped
set ignorecase    " ignore case when searching
set smartcase     " override ignorecase when there are uppercase characters
set showmatch       " when inserting a bracked briefly flash its match
set mouse=a
set history=50
set ruler
set showcmd
colorscheme desert
set incsearch
set hlsearch
set cursorline
hi CursorLine term=none cterm=none ctermbg=DarkBlue
autocmd InsertLeave * hi CursorLine term=none cterm=none ctermbg=DarkBlue
autocmd InsertEnter * hi CursorLine term=none cterm=none ctermbg=DarkBlue
set autoindent
set tabstop=4
set softtabstop=2
set shiftwidth=2
set expandtab
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P>
set enc=utf-8
set backspace=eol,start,indent " make backspace work
set hid " no need to save to change buffers
runtime! macros/matchit.vim
if &t_Co > 1
  syntax enable
endif
" shellslash (use a common path separator across all platforms)
" convert all backslashes to forward slashes on expanding filenames.
" Enables consistancy in Cream between Windows and Linux platforms,
" but BE CAREFUL! Windows file operations require backslashes--any
" paths determined manually (not by Vim) need to be reversed.
set shellslash

" Mappings
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i

inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>

inoremap " <c-r>=QuoteDelim('"')<CR>
"inoremap ' <c-r>=QuoteDelim("'")<CR>

inoremap <S-CR> <ESC>o

" Alt mapped keys (none of these work on mac)
inoremap <m-[> [
inoremap <m-9> (
inoremap <m--> {
inoremap <m-"> "
inoremap <m-'> '

function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

function CloseBracket()
  if match(getline(line('.') + 1), '\s*}') < 0
    return "\<CR>}"
  else
    return "\<ESC>j0f}a"
  endif
endf

function QuoteDelim(char)
  let line = getline('.')
  let col = col('.')
  if line[col - 2] == "\\"
    "Inserting a quoted quotation mark into the string
    return a:char
  elseif line[col - 1] == a:char
    "Escaping out of the string
    return "\<Right>"
  else
    "Starting a string
    return a:char.a:char."\<ESC>i"
  endif
endf

" rails.vim settings
let g:rails_level=4
let g:rails_subversion=1

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
au BufWrite /private/tmp/crontab.* set nobackup

let g:rct_completion_use_fri = 0
command -bar -nargs=1 OpenURL :!open <args>

let $PATH = '~/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:' . $PATH

" Comments
let b:comment_leader = '# '
au FileType haskell,vhdl,ada            let b:comment_leader = '-- '
au FileType vim                         let b:comment_leader = '" '
au FileType c,cpp,java                  let b:comment_leader = '// '
au FileType tex                         let b:comment_leader = '% '
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>
