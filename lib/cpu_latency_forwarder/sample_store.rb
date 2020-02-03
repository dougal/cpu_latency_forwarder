require 'socket'

module CPULatencyForwarder
  class SampleStore

    attr_reader :samples

    def initialize(graphite_host, graphite_port)
      @samples       = {}
      @graphite_host = graphite_host
      @graphite_port = graphite_port
    end

    def empty?
      @samples.empty?
    end

    def record_sample(bucket, value)
      @samples[bucket] = value
    end

    def clear!
      @samples = {}
    end

    def flush!
      # Open new socket for each flush.
      # Tradeoff between being wasteful, and reconnecting on connection failure.
      socket = TCPSocket.open(@graphite_host, @graphite_port)

      @samples.each do |bucket, value|
        write_to_graphite(socket, bucket, value)
      end

      clear!
    ensure
      socket && socket.close
    end

    private

    def write_to_graphite(socket, bucket, value)
      key       = [hostname, 'cpu-lat', bucket].join('.')
      message   = [key, value, timestamp].join(' ') + "\n"

      unless ENV['RUBY_ENV'] == 'test'
        puts "Writing `#{message}` to `#{@graphite_host}:#{@graphite_port}`"
      end

      socket.write(message)
    end

    def timestamp
      Time.now.to_i
    end

    def hostname
      @hostname ||= Socket.gethostname
    end
  end
end
