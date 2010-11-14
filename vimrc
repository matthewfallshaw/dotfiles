set nocompatible      " We're running Vim, not Vi

let $PATH = '~/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:' . $PATH

set encoding=utf8 nobomb " BOM often causes trouble
let mapleader = ","  " <leader> now means ',' rather than '\'
if &t_Co > 1
  syntax enable       " Enable syntax highlighting without clobbering colors
endif
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugin
behave xterm
set visualbell        " must turn visual bell on to remove audio bell
set linebreak                 " when wrapping, try to break at characters in breakat
set breakat=\ ^I!@*-+;:,./?   " when wrapping, break at these characters
set showbreak=>               " character to show that a line is wrapped
set ignorecase    " ignore case when searching
set smartcase     " override ignorecase when there are uppercase characters
set showmatch     " when inserting a bracket briefly flash its match
set modeline
set mouse=a
set history=500
set showcmd
set title
set scrolloff=3
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
colorscheme desert
set incsearch
set hlsearch
nmap <silent> <leader>n :silent :nohlsearch<CR>
set shortmess=atI
set cursorline
hi CursorLine term=none cterm=none ctermbg=DarkBlue
autocmd InsertLeave * hi CursorLine term=none cterm=none ctermbg=DarkBlue
autocmd InsertEnter * hi CursorLine term=none cterm=none ctermbg=DarkBlue
set autoindent
set tabstop=4
set softtabstop=2
set shiftwidth=2
set laststatus=2
set expandtab
set smarttab
autocmd FileType make     set noexpandtab
set ruler
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P>
" Setup automatic text formatting/wrapping:
set formatoptions=
set formatoptions-=t " Don't autowrap text
set formatoptions+=c " Do autowrap comments
set formatoptions+=r " Automatically continue comments
set formatoptions+=o " Automatically continue comments when hitting 'o' or 'O'
set formatoptions+=q " Allow formatting of comments with 'gq'
set formatoptions+=n " Recognize numbered lists
set formatoptions+=l " Don't break long lines that were already there
set textwidth=78     " From settings above, this is only for comments
if has("colorcolumn")
  set colorcolumn=+3   " Highlight column 81
end
" Make window splitting behave
set noequalalways
set splitbelow
" Syntastic plugin
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
" /Syntastic
" GetLatestVimScripts plugin
let g:GetLatestVimScripts_allowautoinstall=1
" /GetLatestVimScripts
set backspace=eol,start,indent " make backspace work
"set hidden " no need to save to change buffers
runtime! macros/matchit.vim
" shellslash (use a common path separator across all platforms)
" convert all backslashes to forward slashes on expanding filenames.
" Enables consistancy in Cream between Windows and Linux platforms,
" but BE CAREFUL! Windows file operations require backslashes--any
" paths determined manually (not by Vim) need to be reversed.
set shellslash
" use ack for grepping
set grepprg=ack
set grepformat=%f:%l:%m
" By default, pressing <TAB> in command mode will choose the first possible completion with no indication of how many others there might be. The following configuration lets you see what your other options are
set wildmenu
set wildmode=list:longest

" Restore cursor position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Mappings
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>

inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>

inoremap " <c-r>=QuoteDelim('"')<CR>
"inoremap ' <c-r>=QuoteDelim("'")<CR>

inoremap <S-CR> <ESC>o
inoremap <C-CR> <ESC><S-o>

" <C-e> and <C-y> scroll the viewport a single line
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

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

" NERDTree
let NERDTreeIgnore=['\~$', '^\.git', '\.swp$', '\.DS_Store$']
let NERDTreeShowHidden=1

" Ruby Block Delimiter Conversion
" vmap <Leader>B :call <SID>RubyBlockSwitchDelimiters()<cr>

" Visual mode copy to pastebuffer
" kudos to Brad: http://xtargets.com/2010/10/13/cutting-and-pasting-source-code-from-vim-to-skype/
function! CopyWithLineNumbers() range
    redir @*
    sil echomsg "----------------------"
    sil echomsg expand("%")
    sil echomsg "----------------------"
    exec 'sil!' . a:firstline . ',' . a:lastline . '#'
    redir END
endf
com! -range CopyWithLineNumbers <line1>,<line2>call CopyWithLineNumbers()
