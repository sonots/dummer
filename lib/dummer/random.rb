module Dummer
  class Random
    def initialize
      @rand = ::Random.new(0)
      @chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a # no symbols and multi-bytes for now
    end

    # belows are data types
    # @return Proc object which returns random generated value

    def string(opts = {})
      length, any, value = (opts[:length] || 8), opts[:any], opts[:value]
      if value
        string = value.to_s
        Proc.new { string }
      elsif any
        Proc.new { self.any(any) }
      else
        Proc.new { Array.new(length){@chars[rand(@chars.size-1)]}.join }
      end
    end

    def integer(opts = {})
      format, range, countup, value = opts[:format], opts[:range], opts[:countup], opts[:value]
      if format
        if value
          integer = sprintf(format, value.to_i)
          Proc.new { integer }
        elsif range
          Proc.new { sprintf(format, self.range(range)) }
        elsif countup
          Proc.new {|prev| sprintf(format, prev.to_i + 1) }
        else
          Proc.new { sprintf(format, rand(0..2,147,483,647)) }
        end
      else
        if value
          integer = value.to_i
          Proc.new { integer }
        elsif range
          Proc.new { self.range(range) }
        elsif countup
          Proc.new {|prev| prev + 1 }
        else
          Proc.new { rand(0..2,147,483,647) }
        end
      end
    end

    def float(opts = {})
      format, range, value = opts[:format], opts[:range], opts[:value]
      if format
        if value
          float = value.to_f
          Proc.new { sprintf(format, float) }
        elsif range
          Proc.new { sprintf(format, self.range(range)) }
        else
          Proc.new { r = rand(1..358); sprintf(format, r * Math.cos(r)) }
        end
      else
        if value
          float = value.to_f
          Proc.new { float }
        elsif range
          Proc.new { self.range(range) }
        else
          Proc.new { r = rand(1..358); r * Math.cos(r) }
        end
      end
    end

    def datetime(opts = {})
      format, random, value = (opts[:format] || "%Y-%m-%d %H:%M:%S.%3N"), (opts[:random] || false), opts[:value]
      if value
        Proc.new { value.strftime(format) }
      elsif random
        Proc.new {
          y = rand(1970..2037);
          m = rand(1..12);
          d = rand(1..27);
          h = rand(0..23);
          min = rand(0..59);
          s = rand(0..59);
          usec = rand(0..999999);
          Time.local(y, m, d, h, min, s, usec).strftime(format)
        }
      else
        Proc.new { Time.now.strftime(format) }
      end
    end

    # private

    def range(range)
      rand(range)
    end

    def any(any)
      any[rand(any.size)]
    end

    def rand(arg = nil)
      @rand.rand(arg)
    end
  end
end
