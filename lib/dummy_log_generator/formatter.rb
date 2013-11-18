module DummyLogGenerator
  class Formatter
    attr_accessor :labeled, :delimiter

    def initialize
      @labeled = true
      @delimiter = "\t"
    end

    def format(fields)
      if labeled
        fields.map {|key, val| "#{key}:#{val}" }.join(delimiter)
      else
        fields.values.join(delimiter)
      end
    end
  end
end
