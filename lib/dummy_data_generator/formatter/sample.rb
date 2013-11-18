module DummyDataGenerator
  module Formatter
    class Sample < Ltsv
      def params
        {
          :time => :datetime,
          :level => %w[DEBUG INFO WARN ERROR],
          :method => %w[GET POST PUT],
          :uri => %w[/api/v1/people /api/v1/textdata /api/v1/messages],
          :reqtime => 0.1..5.0,
        }
      end
    end
  end
end
