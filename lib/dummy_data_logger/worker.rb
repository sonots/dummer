require 'serverengine'

module DummyDataLogger
  module Worker
    def initialize
      reload
    end

    def reload
      @sleep = config[:interval] || 1
      @processor = Processor.new(config)
    end

    def run
      until @stop
        @processor.write
        sleep @sleep
      end
    end

    def stop
      @stop = true
    end
  end
end
