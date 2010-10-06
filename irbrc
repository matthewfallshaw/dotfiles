# Hat tip: Iain Hecker, for console_extensions, http://github.com/iain/osx_settings/blob/master/.irbrc

$: << File.expand_path(File.dirname( File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__ ))
require "lib/irb_helpers"

console_extensions __FILE__ do

  extend_console "rubygems"
  extend_console "interactive_editor"

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
    require 'benchmark'

    def time(times = 1, &block)
      ret = nil
      Benchmark.bm { |x| x.report { times.times { ret = yield } } }
      ret
    end

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
