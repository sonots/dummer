module DummyDataGenerator
  class Formatter
    attr_accessor :labeled, :delimiter, :fields

    def initialize
      @labeled = true
      @delimiter = "\t"
      @fields = {}
    end

    def output(generated_params)
      if labeled
        generated_params.map {|key, val| "#{key}:#{val}" }.join(delimiter)
      else
        generated_params.values.join(delimiter)
      end
    end
  end
end
