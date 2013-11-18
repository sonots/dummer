module DummyLogGenerator
  class Formatter
    attr_accessor :labeled, :delimiter, :fields

    def initialize
      @labeled = true
      @delimiter = "\t"
      @fields = {}
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
