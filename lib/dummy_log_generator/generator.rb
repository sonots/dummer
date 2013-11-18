module DummyLogGenerator
  class Generator
    attr_accessor :fields
    attr_reader :rand

    def initialize
      @fields = {}
      @rand = ::DummyLogGenerator::Random.new
    end

    def generate(prev_data = {})
      data = {}
      fields.each do |key, opts|
        opts = opts.dup
        type = opts.delete(:type)
        opts[:prev] = prev_data[key]
        data[key] = case type
                    when :datetime
                      rand.datetime(opts)
                    when :string
                      rand.string(opts)
                    when :integer
                      rand.integer(opts)
                    when :float
                      rand.float(opts)
                    else
                      raise ConfigError.new(type)
                    end
      end
      data
    end
    alias_method :gen, :generate
  end

  class Random
    def initialize
      @rand = ::Random.new(0)
      @chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a # no symbols and multi-bytes for now
    end

    def string(format: nil, length: 8, any: nil, prev: nil, value: nil)
      string = if value
                 value.to_s
               elsif any
                 self.any(any)
               else
                 Array.new(length){@chars[rand(@chars.size-1)]}.join
               end
      format ? sprintf(format, string) : string
    end

    def integer(format: nil, range: nil, countup: false, prev: nil, value: nil)
      integer = if value
                  value.to_i
                elsif range
                  self.range(range)
                elsif countup
                  prev ||= -1
                  prev.to_i + 1
                else
                  rand(0..2,147,483,647)
                end
      format ? sprintf(format, integer) : integer
    end

    def float(format: nil, range: nil, prev: nil, value: nil)
      float = if value
                value.to_f
              elsif range
                self.range(range)
              else
                r = rand(1..358)
                r * Math.cos(r) # cheat
              end
      format ? sprintf(format, float) : float
    end

    def datetime(format: "%Y-%m-%d %H:%M:%S.%3N", random: false, prev: nil, value: nil)
      time = if value
               value
             elsif random
               y = rand(1970..2037);
               m = rand(1..12);
               d = rand(1..27);
               h = rand(0..23);
               min = rand(0..59);
               s = rand(0..59);
               usec = rand(0..999999);
               Time.local(y, m, d, h, min, s, usec)
             else
               Time.now
             end
      time.strftime(format)
    end

    def range(range)
      rand(range)
    end

    def any(any)
      any[rand(any.size-1)]
    end

    def rand(arg = nil)
      @rand.rand(arg)
    end
  end
end
