module DummyDataGenerator
  module Formatter
    class Ltsv < Base
      def params
        raise NotImplementedError.new
      end

      def delimiter
        "\t"
      end

      def labeled?
        true
      end

      def header
        ""
      end

      def footer
        ""
      end
    end
  end
end
