# Hat tip: Iain Hecker, http://github.com/iain/osx_settings/blob/master/.irbrc

$: << File.expand_path(File.dirname( File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__ ))
require "lib/irb_helpers"

console_extensions __FILE__ do


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

#   extend_console 'colorful-prompt', true, false do
#     # Build a simple colorful IRB prompt
#     IRB.conf[:PROMPT][:SIMPLE_COLOR] = {
#       :PROMPT_I => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
#       :PROMPT_N => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
#       :PROMPT_C => "#{ANSI[:RED]}?>#{ANSI[:RESET]} ",
#       :PROMPT_S => "#{ANSI[:YELLOW]}?>#{ANSI[:RESET]} ",
#       :RETURN   => "#{ANSI[:GREEN]}=>#{ANSI[:RESET]} %s\n",
#       :AUTO_INDENT => true }
#     }
#     IRB.conf[:PROMPT_MODE] = :SIMPLE_COLOR
#   end

  %w[rubygems interactive_editor].each {|l| extend_console l }

  extend_console 'wirble' do
    Wirble.init(:history_size => 10000)
    Wirble.colorize
  end

  extend_console 'ap' do
    alias pp ap
  end

  extend_console '#enable_trace #disable_trace' do
    def enable_trace( event_regex = /^(call|return)/, class_regex = /IRB|Wirble|RubyLex|RubyToken/ )
      puts "Enabling method tracing with event regex #{event_regex.inspect} and class exclusion regex #{class_regex.inspect}"

      set_trace_func Proc.new { |event, file, line, id, binding, classname|
        printf "[%8s] %30s %30s (%s:%-2d)\n", event, id, classname, file, line if
          event          =~ event_regex and
          classname.to_s !~ class_regex
      }
      return
    end
    def disable_trace
      puts "Disabling method tracing"

      set_trace_func nil
    end
  end

  extend_console '#time' do
    def time(times = 1)
      ret = nil
      Benchmark.bm { |x| x.report { times.times { ret = yield } } }
      ret
    end

    if defined? Benchmark
      class Benchmark::ReportProxy
        def initialize(bm, iterations)
          @bm = bm
          @iterations = iterations
          @queue = []
        end
        
        def method_missing(method, *args, &block)
          args.unshift(method.to_s + ':')
          @bm.report(*args) do
            @iterations.times { block.call }
          end
        end
      end

      def compare(times = 1, label_width = 12)
        Benchmark.bm(label_width) do |x|
          yield Benchmark::ReportProxy.new(x, times)
        end
      end
    end
  end

  extend_console '#local_methods #non_object_methods' do
    class Object
      # Return a list of methods defined locally for a particular object.  Useful
      # for seeing what it does whilst losing all the guff that's implemented
      # by its parents (eg Object).
      def local_methods(obj = self)
        (obj.methods - obj.class.superclass.instance_methods).sort
      end
      def non_object_methods(obj = self)
        (obj.methods - Object.instance_methods).sort
      end
    end
  end

end

# .railsrc
load File.dirname(__FILE__) + '/.railsrc' if ( ENV['RAILS_ENV'] || defined?(RAILS_ENV) || defined?(Rails) )
