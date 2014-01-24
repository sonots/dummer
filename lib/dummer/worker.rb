require 'serverengine'

module Dummer
  module Worker
    BIN_NUM = 10

    def initialize
      reload
    end

    def reload
      @generator = Generator.new(config[:setting])
      @rate = config[:setting].rate

      output = config[:setting].output
      if output.respond_to?(:write) and output.respond_to?(:close)
        @output = output
      else
        @output = open(output, (File::WRONLY | File::APPEND | File::CREAT))
        @output.sync = true
      end
    end

    def run
      batch_num    = (@rate / BIN_NUM).to_i
      residual_num = (@rate % BIN_NUM)
      while !@stop
        current_time = Time.now.to_i
        BIN_NUM.times do
          break unless (!@stop && Time.now.to_i <= current_time)
          wait(0.1) { write(batch_num) }
        end
        write(residual_num)
        # wait for next second
        while !@stop && Time.now.to_i <= current_time
          sleep 0.01
        end
      end
    ensure
      @output.close
    end

    def stop
      @stop = true
    end

private

    def write(num)
      num.times { @output.write @generator.generate }
    end

    def wait(time)
      start_time = Time.now
      yield
      sleep_time = time - (Time.now - start_time)
      sleep sleep_time if sleep_time > 0
    end
  end
end
