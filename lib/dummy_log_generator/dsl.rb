module DummyLogGenerator
  class Config
    attr_accessor :rate

    def initiaize
      @rate = 500
    end
  end
end

module DummyLogGenerator
  class Dsl
    attr_reader :generator
    attr_reader :formatter
    attr_reader :config

    def initialize
      @generator = Generator.new
      @formatter = Formatter.new
      @config = Config.new
    end

    def rate(rate)
      config.rate = rate
    end

    def field(name, opts)
      generator.fields[name] = opts
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
  dsl = DummyLogGenerator::Dsl.new
  dsl.instance_eval(&block)
  dsl
end
