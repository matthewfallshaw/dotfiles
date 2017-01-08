# secrets in ~/.dotfiles_secrets like
# filename:
#   "search_term": replace_term
#   "other_search_term": other_replace_term

%w[rubygems rake yaml shellwords tempfile].each {|l| require l }

IGNORE_LIST = %w[install.rb Rakefile README vendor lib tags]
DESTDIR = File.expand_path("~")
SOURCEDIR = File.dirname(__FILE__)
SECRETS = File.expand_path('~/.dotfiles_secrets')

task :default => :all

def secrets
  @secrets ||= begin
                 if File.exist?(SECRETS)
                   YAML.load(open(SECRETS))
                 else
                   warn <<-WARN
I can't find a ~/.dotfiles_secrets file... unless you're sure you don't have any secrets
  (and who can be sure of that?), this probably isn't going to work.
WARN
                   {}
                 end
               end
end
dotfiles = Rake::FileList.new('*') do |df|
  IGNORE_LIST.each do |f|
    df.exclude(f)
  end
end
dotfiles_with_secrets = dotfiles.clone
dotfiles_with_secrets.exclude do |f|
  !secrets.keys.include?(f)
end
dotfiles_without_secrets = dotfiles - dotfiles_with_secrets
 
desc <<DESC
install dotfiles into user's home directory, and replace secrets defined in ~/.dotfiles_secrets
(~/.dotfiles_secrets should look like:
  gitconfig:
    "search_term": replace_term
    "other_search_term": other_replace_term
)
DESC
task all: dotfiles

def target(dotfile)
  File.join(DESTDIR, ".#{dotfile}")
end

dotfiles_without_secrets.each do |dotfile|
  desc "Symlink #{dotfile}."
  task dotfile do
    if File.symlink?(target(dotfile))
      if File.identical?(target(dotfile), dotfile)
        # Already linked
        puts "#{dotfile}: already correctly linked."
      else
        # Symlink to wrong place
        old_target = File.readlink(target(dotfile))
        ln_sf File.expand_path(dotfile), target(dotfile)
        puts "#{dotfile} fixed: erroneously linked to #{old_target}, fixed."
      end
    elsif File.exist?(target(dotfile))
      print "#{dotfile}: exists, should be a symlink but is a real file, overwrite #{target(dotfile)}? [ynaq] "
      case $stdin.gets.chomp
      when "q"
        exit 1
      when "n"
        puts "      #{dotfile} not linked!!"
      when "y"
        ln_sf File.expand_path(dotfile), target(dotfile)
        puts "      #{dotfile} linked."
      when "a"
        ln_sf File.expand_path(dotfile), target(dotfile)
        puts "      #{dotfile} linked."
        @always_update = true
      else
        raise "I asked for [ynaq] and you give me that?! I quit."
      end
    else
      # Not linked
      ln_sf File.expand_path(dotfile), target(dotfile)
      puts "#{dotfile}: linked."
    end
  end
end

dotfiles_with_secrets.each do |dotfile|
  desc "Copy and update #{dotfile}."
  task dotfile do
    if File.directory?(dotfile)
      raise "Your #{SECRETS} includes configuration for the directory #{dotfile}, which is not supported."
    end

    tempfile = Tempfile.new(dotfile)
    begin
      # Generate the updated file
      cp dotfile, tempfile.path, verbose: false
      secrets[dotfile].each do |search_term, replace_term|
        sh %[ruby -pi -e 'gsub(/#{search_term.shellescape}/, "#{replace_term.shellescape}")' "#{tempfile.path}"], verbose: false
      end
      if !File.exist?(target(dotfile))
        # If no current file, copy ours over
        cp tempfile.path, target(dotfile), verbose: false
        puts "#{dotfile}: created and updated with secrets."
      elsif compare_file(target(dotfile), tempfile.path)
        # Current file exists but is identical, nothing to do.
        puts "#{dotfile}: exists & identical. Unchanged."
      else
        # Current file exists and differs
        if @always_update
          cp tempfile.path, target(dotfile), verbose: false
          puts "#{dotfile}: exists and differs. Updated."
        else
          print "#{dotfile}: exists and differs, overwrite #{target(dotfile)}? [ynaq] "
          case $stdin.gets.chomp
          when "q"
            exit 1
          when "n"
            puts "      #{dotfile} not updated!!"
          when "y"
            cp tempfile.path, target(dotfile), verbose: false
            puts "      #{dotfile} updated."
          when "a"
            cp tempfile.path, target(dotfile), verbose: false
            puts "      #{dotfile} updated."
            @always_update = true
          else
            raise "I asked for [ynaq] and you give me that?! I quit."
          end
        end
      end
    ensure
      tempfile.close
      sh "shred #{tempfile.path}", verbose: false
      tempfile.unlink
    end
  end
end

namespace "remove" do
  dotfiles.each do |dotfile|
    desc "Remove #{dotfile} from this directory and ~"
    task dotfile do
      rm_r dotfile
      rm_r target(dotfile)
    end
  end
end
