# Hat tip: Iain Hecker, http://github.com/iain/osx_settings/blob/master/.irbrc

# Loading extensions of the console. This is wrapped
# because some might not be included in your Gemfile
# and errors will be raised
def extend_console(name, enabled = true, required = true)
  if name.match(/^#/) && required
    required = false
  end
  if enabled
    require name if required
    yield if block_given?
    $console_extensions << "#{ANSI[:GREEN]}#{name}#{ANSI[:RESET]}"
  else
    $console_extensions << "#{ANSI[:LGRAY]}#{name}#{ANSI[:RESET]}"
  end
rescue LoadError
  $console_extensions << "#{ANSI[:RED]}#{name}#{ANSI[:RESET]}"
end
$console_extensions = []

def console_extensions(file = File.expand_path(File.dirname(__FILE__)))
  $console_extensions = []

  yield

  # Show results of all extension-loading
  f = File.basename(file)
  puts "#{ANSI[:LGRAY]}~> Console extensions (#{f}):#{ANSI[:RESET]} #{$console_extensions.join(' ')}#{ANSI[:RESET]}"
end
