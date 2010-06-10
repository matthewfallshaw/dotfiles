if version < 600
  source <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif
if version < 508
  command! -nargs=+ HtmlHiLink highlight link <args>
else
  command! -nargs=+ HtmlHiLink highlight def link <args>
endif
syntax spell toplevel
syntax case ignore
syntax sync linebreaks=1
syntax region rdocBold      start=/\\\@<!\(^\|\A\)\@=\*\(\s\|\W\)\@!\(\a\{1,}\s\|$\n\)\@!/ skip=/\\\*/ end=/\*\($\|\A\|\s\|\n\)\@=/ contains=@Spell
syntax region rdocEmphasis  start=/\\\@<!\(^\|\A\)\@=_\(\s\|\W\)\@!\(\a\{1,}\s\|$\n\)\@!/  skip=/\\_/  end=/_\($\|\A\|\s\|\n\)\@=/  contains=@Spell
syntax region rdocMonospace start=/\\\@<!\(^\|\A\)\@=+\(\s\|\W\)\@!\(\a\{1,}\s\|$\n\)\@!/  skip=/\\+/  end=/+\($\|\A\|\s\|\n\)\@=/  contains=@Spell
syntax region rdocLink matchgroup=rdocDelimiter start="\!\?{" end="}\ze\s*[\[\]]" contains=@Spell nextgroup=rdocURL,rdocID skipwhite oneline
syntax region rdocID   matchgroup=rdocDelimiter start="{"     end="}"  contained
syntax region rdocURL  matchgroup=rdocDelimiter start="\["    end="\]" contained
syntax match  rdocLineContinue ".$" contained
syntax match  rdocRule      /^\s*\*\s\{0,1}\*\s\{0,1}\*$/
syntax match  rdocRule      /^\s*-\s\{0,1}-\s\{0,1}-$/
syntax match  rdocRule      /^\s*_\s\{0,1}_\s\{0,1}_$/
syntax match  rdocRule      /^\s*-\{3,}$/
syntax match  rdocRule      /^\s*\*\{3,5}$/
syntax match  rdocListItem  "^\s*[-*+]\s\+"
syntax match  rdocListItem  "^\s*\d\+\.\s\+"
syntax match  rdocLineBreak /  \+$/
syntax match  rdocCode  /^\s*\n\(\(\s\{1,}[^ ]\|\t\+[^\t]\).*\n\)\+/
syntax region rdocCode  start="<pre[^>]*>"         end="</pre>"
syntax region rdocCode  start="<code[^>]*>"        end="</code>"
syntax region htmlH1  start="^\s*="       end="\($\)" contains=@Spell
syntax region htmlH2  start="^\s*=="      end="\($\)" contains=@Spell
syntax region htmlH3  start="^\s*==="     end="\($\)" contains=@Spell
syntax region htmlH4  start="^\s*===="    end="\($\)" contains=@Spell
syntax region htmlH5  start="^\s*====="   end="\($\)" contains=@Spell
syntax region htmlH6  start="^\s*======"  end="\($\)" contains=@Spell
HtmlHiLink rdocCode         String
HtmlHiLink rdocBlockquote   Comment
HtmlHiLink rdocLineContinue Comment
HtmlHiLink rdocListItem     Identifier
HtmlHiLink rdocRule         Identifier
HtmlHiLink rdocLineBreak    Todo
HtmlHiLink rdocLink         htmlLink
HtmlHiLink rdocURL          htmlString
HtmlHiLink rdocID           Identifier
HtmlHiLink rdocBold         htmlBold
HtmlHiLink rdocEmphasis     htmlItalic
HtmlHiLink rdocMonospace    String
HtmlHiLink rdocDelimiter     Delimiter
let b:current_syntax = "rdoc"
delcommand HtmlHiLink
