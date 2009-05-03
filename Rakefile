%w[rubygems rake].each {|l| require l }
 
desc <<DESC
install dotfiles into user's home directory, and replace secrets defined in ~/.dotfiles_secrets
(~/.dotfiles_secrets should look like:
  gitconfig:
    "search_term": replace_term
    "other_search_term": other_replace_term
)
DESC
task :install do
  $:.unshift File.dirname(__FILE__)
  load 'install.rb'
end
