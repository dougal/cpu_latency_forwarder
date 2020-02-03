require 'optparse'

module CPULatencyForwarder
  class Command

    def initialize
      @graphite_host   = 'localhost'
      @graphite_port   = '2003'
      @script_location = '/root/cpu_latency.bt'
      @flush_interval  = 15
    end

    def run!
      parse_options

      store = SampleStore.new(@graphite_host, @graphite_post)
      epoch  = Time.now + @flush_interval

      IO.popen(@script_location) do |f|
        while true do
          line = HistogramLine.new(f.gets)
          if line.has_data?
            store.record_sample(line.lower_bound, line.value)
          end

          if Time.now >= epoch
            store.flush!
            epoch = Time.now + @flush_interval
          end
        end
      end
    end
    
    private

    def parse_options
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: ./bin/run"

        opts.on("-h HOSTNAME", String, "Specify the Graphite hostname. Default is 'localhost'.") do |v|
          @graphite_host = v
        end

        opts.on("-p PORT", Integer, "Specify the Graphite port. Default is '2003'.") do |v|
          @graphite_port = v
        end

        opts.on("-c PATH", Integer, "Specify the path of the CPU sampling script. Default is '/root/cpu_latency.bt'.") do |v|
          @script_location = v
        end

        opts.on("-i SECONDS", Integer, "Specify the period used to flush samples to Graphite. Default is '15'.") do |v|
          @flush_interval = v
        end
      end

      parser.parse!
    end

  end
end
