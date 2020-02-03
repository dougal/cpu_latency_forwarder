module CPULatencyForwarder
  class HistogramLine
    
    def initialize(raw)
      @raw         = raw
      @parsed      = false
      @lower_bound = nil
      @value       = nil
    end

    def has_data?
      !@lower_bound.nil? && !@value.nil?
    end

    def lower_bound
      parse

      @lower_bound
    end

    def value
      parse

      @value
    end

    private

    def parse
      if @parsed
        return
      end

      # Match an opening square bracket `[`, followed by an integer of at least
      # one digit.
      @raw[%r{^\[(\d+)}]
      if $1
        @lower_bound = $1.to_i
      end

      # Match an integer of at least one digit, followed by whitespace,
      # followed by a pipe, `|`.
      @raw[%r{(\d+)\s+\|}]
      if $1
        @value = $1.to_i
      end

      @parsed = true
    end
  end
end
