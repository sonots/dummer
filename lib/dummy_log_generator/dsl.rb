module DummyLogGenerator
  class Dsl
    attr_reader :setting

    def initialize
      @setting = Setting.new
    end

    def method_missing(name, *args)
      if @setting.respond_to?("#{name}=")
        @setting.__send__("#{name}=", *args)
      else
        raise ConfigError.new("Config parameter `#{name}` does not exist")
      end
    end

    def field(name, opts)
      setting.fields ||= {}
      setting.fields[name] = opts
    end
  end
end

def configure(title, &block)
  dsl = DummyLogGenerator::Dsl.new
  dsl.instance_eval(&block)
  dsl
end
