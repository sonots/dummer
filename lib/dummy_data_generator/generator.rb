module DummyDataGenerator
  class Generator
    attr_reader :formatter
    attr_reader :rand

    def initialize(formatter)
      @formatter = formatter
      @rand = ::DummyDataGenerator::Random.new
    end

    def generate
      fields = {}
      formatter.fields.each do |key, opts|
        opts = opts.dup
        type = opts.delete(:type)
        fields[key] = case type
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
      formatter.output(fields)
    end
    alias_method :gen, :generate
  end

  class Random
    def initialize
      @rand = ::Random.new(0)
      @chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a # no symbols and multi-bytes for now
    end

    def string(length: 8, any: nil)
      unless any.nil?
        self.any(any)
      else
        Array.new(length){@chars[rand(@chars.size-1)]}.join
      end
    end

    def interger(range: nil)
      unless range.nil?
        self.range(range)
      else
        rand(0..2,147,483,647)
      end
    end

    def float(range: nil)
      unless range.nil?
        self.range(range)
      else
        r = rand(1..358)
        r * Math.cos(r) # cheat
      end
    end

    def datetime(format: "%Y-%m-%d %H:%M:%S.%3N")
      y = rand(1970..2037);
      m = rand(1..12);
      d = rand(1..27);
      h = rand(0..23);
      min = rand(0..59);
      s = rand(0..59);
      usec = rand(0..999999);
      Time.local(y, m, d, h, min, s, usec).strftime(format)
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
