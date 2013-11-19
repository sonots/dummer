require 'serverengine'

module DummyLogGenerator
  module Worker
    def initialize
      reload
    end

    def reload
      @rate = config[:rate]
      @formatter = config[:formatter]
      @generator = config[:generator]

      output = config[:output]
      if output.respond_to?(:write) and output.respond_to?(:close)
        @output = output
      else
        @output = open(output, (File::WRONLY | File::APPEND | File::CREAT))
        @output.sync = true
      end
    end

    # thanks! ref. https://github.com/tagomoris/fluent-plugin-dummydata-producer/blob/a550fd4424f71cd9227e138c3c89f600ba40a0d5/lib/fluent/plugin/in_dummydata_producer.rb#L63
    def run
      batch_num = (@rate / 9).to_i + 1
      prev_data  = {}
      while !@stop
        current_time = Time.now.to_i
        rate_count = 0

        while !@stop && rate_count < @rate && Time.now.to_i == current_time
          batch_num.times do
            # ToDo: what if generation is slower than I/O?
            # We may should generate data and output in parallel
            prev_data = @generator.generate(prev_data)
            @output.write "#{@formatter.format(prev_data)}\n"
          end
          rate_count += batch_num
          sleep 0.1
        end
        # wait for next second
        while !@stop && Time.now.to_i == current_time
          sleep 0.04
        end
      end
    ensure
      @output.close
    end

    def stop
      @stop = true
    end
  end
end
