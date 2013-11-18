module DummyDataLogger
  class Processor
    attr_accessor :logger

    def initialize(options)
      opts = options.dup
      opts[:shift_age] ||= 0
      opts[:shfit_size] ||= 1048576
      @logger = Logger.new(opts[:logdev], opts[:shift_age], opts[:shift_size])
    end

    def write
    end

  end
end
