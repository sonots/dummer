require 'serverengine'

module DummyLogGenerator
  module Worker
    def initialize
      reload
    end

    def reload
      @rate = config[:rate] || 500 # msgs / sec
      @formatter = config[:formatter]
      @generator = Generator.new(@formatter)
    end

    def run
      batch_num = (@rate / 9).to_i + 1
      while !@stop
        current_time = Time.now.to_i
        rate_count = 0

        while !@stop && rate_count < @rate && Time.now.to_i == current_time
          batch_num.times do
            # ToDo: what if generation is slower than I/O?
            STDOUT.puts @generator.generate
          end
          rate_count += batch_num
          sleep 0.1
        end
        # wait for next second
        while !@stop && Time.now.to_i == current_time
          sleep 0.04
        end
      end
    end

    def stop
      @stop = true
    end
  end
end
