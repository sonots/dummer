module DummyLogGenerator
  class Dsl
    attr_reader :setting

    def initialize
      @setting = Setting.new
    end

    def rate(rate)
      setting.rate = rate
    end

    def output(output)
      setting.output = output
    end

    def field(name, opts)
      setting.fields[name] = opts
    end

    def delimiter(delimiter)
      setting.delimiter = delimiter
    end

    def labeled(labeled)
      setting.labeled = labeled
    end

    def workers(workers)
      setting.workers = workers
    end
  end
end

def configure(title, &block)
  dsl = DummyLogGenerator::Dsl.new
  dsl.instance_eval(&block)
  dsl
end
