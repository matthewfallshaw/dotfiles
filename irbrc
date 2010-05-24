%w[rubygems wirble pp ap interactive_editor].each {|l| require l }

# require "irb/completion"
# require 'irb/ext/save-history'
# IRB.conf[:SAVE_HISTORY] = 10000
# IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history" 

# Wirble
Wirble.init(:history_size => 10000)
Wirble.colorize

IRB.conf[:AUTO_INDENT] = true

# Tracing execution
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

# .railsrc
load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']

# Benchmarking
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
