module DummyDataGenerator
  class Dsl
    attr_reader :formatter
    attr_reader :config

    def initialize
      @formatter = Formatter.new
      @config = OpenStruct.new
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

