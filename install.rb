#!/usr/bin/env ruby

# (originally) from http://errtheblog.com/posts/89-huba-huba
# (I took this from git://github.com/mislav/dotfiles.git)
# modified to support secrets appended after install
#   secrets in ~/.dotfiles_secrets like
#   gitconfig:
#     "search_term": replace_term
#     "other_search_term": other_replace_term

def copy_and_replace_secrets(file, target, secrets)
  %w[rubygems facets/shellwords].each {|l| require l }
  system %[cp #{file} #{target}]
  secrets[file].each do |search_term, replace_term|
    system %[ruby -pi -e 'gsub(/#{Shellwords.escape(search_term)}/, "#{Shellwords.escape(replace_term)}")' #{target}]
  end
  puts "copy and update .#{file}"
end
def symlink(file, target)
  system %[ln -vsf #{File.join(Dir.pwd, file)} #{target}]
end

home = ENV['HOME']
require 'yaml'
secrets = YAML.load(open(File.expand_path('~/.dotfiles_secrets')))

Dir.chdir File.dirname(__FILE__) do
  Dir['*'].each do |file|
    next if file.match(/^(install.rb|vendor)$/)
    target = File.join(home, ".#{file}")
    if secrets[file]
      copy_and_replace_secrets(file, target, secrets)
    elsif !File.exist?(target)
      symlink(file, target)
    end
  end
end
