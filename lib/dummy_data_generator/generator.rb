module DummyDataGenerator
  class Generator
    attr_reader :formatter

    def initialize(formatter)
      @formatter = formatter
      @rand = Random.new(0)
      @chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a # no symbols and multi-bytes for now
    end

    def generate
      params = {}
      formatter.params.each do |key, value|
        params[key] = if value == :datetime
                        rand_datetime
                      elsif value == :string
                        rand_string
                      elsif value == :integer
                        rand_integer
                      elsif value.class == Range
                        rand_range(value)
                      elsif value.class == Array
                        rand_array(value)
                      else
                        value
                      end
      end
      formatter.output(params)
    end
    alias_method :gen, :generate

    private
    def rand_range(range)
      rand(range)
    end

    def rand_array(array)
      array[rand(array.size-1)]
    end

    def rand_string(length = 128)
      Array.new(length){@chars[rand(@chars.size-1)]}.join
    end

    def rand_interger
      rand(0..2,147,483,647)
    end

    def rand_datetime
      y = rand(1970..2037);
      m = rand(1..12);
      d = rand(1..27);
      h = rand(0..23);
      min = rand(0..59);
      s = 0
      Time.local(y, m, d, h, min, s).strftime("%Y-%m-%d %H:%M:%S")
    end

    def rand(arg = nil)
      @rand.rand(arg)
    end
  end
end
