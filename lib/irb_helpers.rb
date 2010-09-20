# Hat tip: Iain Hecker, http://github.com/iain/osx_settings/blob/master/.irbrc

ANSI = {
  :RESET     => "\e[0m",
  :BOLD      => "\e[1m",
  :UNDERLINE => "\e[4m",
  :LGRAY     => "\e[0;37m",
  :GRAY      => "\e[1;30m",
  :RED       => "\e[31m",
  :GREEN     => "\e[32m",
  :YELLOW    => "\e[33m",
  :BLUE      => "\e[34m",
  :MAGENTA   => "\e[35m",
  :CYAN      => "\e[36m",
  :WHITE     => "\e[37m",
}

# Build a simple colorful IRB prompt
IRB.conf[:PROMPT][:SIMPLE_COLOR] = {
  :PROMPT_I => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
  :PROMPT_N => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
  :PROMPT_C => "#{ANSI[:RED]}?>#{ANSI[:RESET]} ",
  :PROMPT_S => "#{ANSI[:YELLOW]}?>#{ANSI[:RESET]} ",
  :RETURN   => "#{ANSI[:GREEN]}=>#{ANSI[:RESET]} %s\n",
  :AUTO_INDENT => true }
IRB.conf[:PROMPT_MODE] = :SIMPLE_COLOR
IRB.conf[:AUTO_INDENT] = true

# Loading extensions of the console. This is wrapped
# because some might not be included in your Gemfile
# and errors will be raised
def extend_console(name, care = true, required = true)
  if name.match(/^#/) && required
    required = false
  end
  if care
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
