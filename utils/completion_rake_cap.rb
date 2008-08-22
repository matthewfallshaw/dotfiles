#!/usr/bin/env ruby
 
# If you update your tasks, just $ rm ~/.(rake|cap)tabs*
# complete -C "ruby -r${path/to/this/file} -e 'puts complete_tasks(:rake)'" -o default rake
# complete -C "ruby -r${path/to/this/file} -e 'puts complete_tasks(:cap)'" -o default cap
#
# Taken from (without modification)
# http://github.com/adamj/dot-files/tree/master/bash_completion.rb
# Adapted from
# http://errtheblog.com/posts/31-rake-around-the-rosie
# Adapted from
# http://onrails.org/articles/2006/08/30/namespaces-and-rake-command-completion
 
$tasks_cmd = {
  :rake => 'rake -sT',
  :cap => 'cap -Tv'
}
$task_files = {
  :rake => 'Rakefile',
  :cap => 'Capfile'
}
 
def task_file(cmd)
  File.join(Dir.pwd, $task_files[cmd])
end
 
def tasks(cmd)
  if File.exists?(dotcache = File.join(File.expand_path('~'), ".#{cmd}tabs-#{Dir.pwd.hash}"))
    return File.read(dotcache) if File.mtime(task_file(cmd)) < File.mtime(dotcache)
  end
  tasks = `#{$tasks_cmd[cmd]} | grep ^#{cmd} | cut -d' ' -f2`
  File.open(dotcache, 'w') { |f| f.puts tasks }
  tasks.split("\n")
end
 
def complete_tasks(cmd)
  return [] unless /\b#{cmd}\b/ =~ ENV["COMP_LINE"]
  return [] unless File.file?(task_file(cmd))
  after_match = $'
  task_match = (after_match.empty? || after_match =~ /\s$/) ? nil : after_match.split.last
  tasks = tasks(cmd)
  tasks = tasks.select { |t| /^#{Regexp.escape task_match}/ =~ t } if task_match
  # handle namespaces
  if task_match =~ /^([-\w:]+:)/
    upto_last_colon = $1
    after_match = $'
    tasks = tasks.map { |t| (t =~ /^#{Regexp.escape upto_last_colon}([-\w:]+)$/) ? "#{$1}" : t }
  end
  tasks
end
