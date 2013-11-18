module DummyDataGenerator
  class Config
    attr_accessor :rate

    def initiaize
      @rate = 500
    end
  end

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

module DummyDataGenerator
  class Dsl
    attr_reader :formatter
    attr_reader :config

    def initialize
      @formatter = Formatter.new
      @config = Config.new
    end

    def rate(rate)
      config.rate = rate
    end

    def field(name, opts)
      formatter.fields[name] = opts
    end

    def delimiter(delimiter)
      formatter.delimiter = delimiter
    end

    def labeled(labeled)
      formatter.labeled = labeled
    end
  end
end

def configure(title, &block)
  dsl = DummyDataGenerator::Dsl.new
  dsl.instance_eval(&block)
  dsl
end
