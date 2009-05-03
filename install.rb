#!/usr/bin/env ruby

# (originally) from http://errtheblog.com/posts/89-huba-huba
# (I took this from git://github.com/mislav/dotfiles.git)
# modified to support secrets appended after install
#   secrets in ~/.dotfiles_secrets like
#   gitconfig:
#     "search_term": replace_term
#     "other_search_term": other_replace_term

%w[rubygems rake yaml].each {|l| require l }

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end
 
def link_file(file)
  puts ".#{file}: linked"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def copy_and_replace_secrets(file)
  require 'facets/shellwords'
  system %[cp "$PWD/#{file}" "$HOME/.#{file}"]
  secrets[file].each do |search_term, replace_term|
    system %[ruby -pi -e 'gsub(/#{Shellwords.escape(search_term)}/, "#{Shellwords.escape(replace_term)}")' "$HOME/.#{file}"]
  end
  puts ".#{file}: copied and updated with secrets"
end

def secrets
  @secrets ||= YAML.load(open(File.expand_path('~/.dotfiles_secrets')))
end

replace_all = false
Dir.chdir File.dirname(__FILE__) do
  Dir['*'].each do |file|
    next if %w[install.rb Rakefile README vendor].include?(file)

    original = File.join(ENV['HOME'], ".#{file}")

    if secrets[file]
      copy_and_replace_secrets(file)
    elsif File.symlink?(original) && ( File.readlink(original) == File.expand_path(file) )
      puts ".#{file}: already correctly linked"
    elsif replace_all
      replace_file(file)
    elsif File.exist?(original)
      print "overwrite ~/.#{file}? [ynaq] "
      case $stdin.gets.chomp
      when 'a'
        replace_all = true
        replace_file(file)
      when 'y'
        replace_file(file)
      when 'q'
        exit
      else
        puts ".#{file}: skipped"
      end
    else
      link_file(file)
    end
  end
end
