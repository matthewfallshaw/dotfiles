if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet rb #!/usr/bin/env ruby<CR>"
exec "Snippet : :".st."key".et." => \"".st."value".et."\"".st.et.""
exec "Snippet begin begin<CR>".st.et."<CR>rescue ".st."Exception".et." => ".st."e".et."<CR>".st.et."<CR>end"
exec "Snippet case case ".st."object".et."<CR>when ".st."condition".et."<CR>".st.et."<CR>end"
exec "Snippet class class ".st."className".et."<CR>".st.et."<CR>end"
exec "Snippet collect collect { |".st."element".et."| ".st."element".et.".".st.et." }"
exec "Snippet collecto collect do |".st."element".et."|<CR>".st."element".et.".".st.et."<CR>end"
exec "Snippet def def ".st."methodName".et."<CR>".st.et."<CR>end"
exec "Snippet defa def ".st."methodName".et."(".st."arg".et.")<CR>".st.et."<CR>end"
exec "Snippet do do<CR>".st.et."<CR>end"
exec "Snippet doo do |".st."object".et."|<CR>".st.et."<CR>end"
exec "Snippet each each { |".st."element".et."| ".st."element".et.".".st.et." }"
exec "Snippet eacho each do |".st."element".et."|<CR>".st."element".et.".".st.et."<CR>end"
exec "Snippet each_with_index each_with_index { |".st."element".et.", ".st."idx".et."| ".st."element".et.".".st.et." }"
exec "Snippet each_with_indexo each_with_index do |".st."element".et.", ".st."index".et."|<CR>".st."element".et.".".st.et."<CR>end"
exec "Snippet forin for ".st."element".et." in ".st."collection".et."<CR>".st."element".et.".".st.et."<CR>end"
exec "Snippet if if ".st."condition".et."<CR>".st.et."<CR>end"
exec "Snippet ife if ".st."condition".et."<CR>".st.et."<CR>else<CR>".st.et."<CR>end"
exec "Snippet inject inject(".st."object".et.") { |".st."injection".et.", ".st."element".et."| ".st.et." }"
exec "Snippet injecto inject(".st."object".et.") do |".st."injection".et.", ".st."element".et."|<CR>".st.et."<CR>end"
exec "Snippet mod module ".st."module".et."<CR>".st.et."<CR>end"
exec "Snippet reject { |".st."element".et."| ".st."element".et.".".st.et." }"
exec "Snippet rejecto reject do |".st."element".et."| <CR>".st."element".et.".".st.et."<CR>end"
exec "Snippet select select { |".st."element".et."| ".st."element".et.".".st.et." }"
exec "Snippet selecto select do |".st."element".et."|<CR>".st."element".et.".".st.et."<CR>end"
exec "Snippet task namespace '".st."foo".et."' do<CR>namespace '".st."bar".et."' do<CR>desc '".st."Description".et."'<CR>task :".st."baz".et." do<CR>".st.et."<CR>end<CR>end<CR>end"
exec "Snippet unless unless ".st."condition".et."<CR>".st.et."<CR>end"
exec "Snippet when when ".st."condition".et.""
