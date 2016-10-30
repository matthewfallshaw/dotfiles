#!/usr/bin/env ruby

# secrets in ~/.dotfiles_secrets like
# filename:
#   "search_term": replace_term
#   "other_search_term": other_replace_term

%w[rubygems rake].each {|l| require l }

app = Rake.application
app.init
app.load_rakefile
app['all'].invoke
