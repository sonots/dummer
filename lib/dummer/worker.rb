require 'serverengine'

module Dummer
  module Worker
    BIN_NUM = 10

    def initialize
      reload
    end

    def reload
      setting = config[:setting]
      @generator = Generator.new(setting)
      @rate = setting.rate

      if host = setting.host and port = setting.port
        @client = Fluent::Logger::FluentLogger.new(nil, :host => host, :port => port)
      elsif output = setting.output
        if output.respond_to?(:write) and output.respond_to?(:close)
          @file = output
        else
          @file = open(output, (File::WRONLY | File::APPEND | File::CREAT))
          @file.sync = true
        end
      else
        raise ConfigError.new("Config parameter `output`, or `host` and `port` do not exist")
      end

      @write_proc =
        if @client
          Proc.new {|num| num.times { @client.post("dummer", @generator.generate_record) } }
        else # @file
          Proc.new {|num| num.times { @file.write @generator.generate } }
        end
    end

    def run
      batch_num    = (@rate / BIN_NUM).to_i
      residual_num = (@rate % BIN_NUM)
      while !@stop
        current_time = Time.now.to_i
        BIN_NUM.times do
          break unless (!@stop && Time.now.to_i <= current_time)
          wait(0.1) { @write_proc.call(batch_num) }
        end
        @write_proc.call(residual_num)
        # wait for next second
        while !@stop && Time.now.to_i <= current_time
          sleep 0.01
        end
      end
    ensure
      @file.close
    end

    def stop
      @stop = true
    end

private

    def wait(time)
      start_time = Time.now
      yield
      sleep_time = time - (Time.now - start_time)
      sleep sleep_time if sleep_time > 0
    end
  end
end
