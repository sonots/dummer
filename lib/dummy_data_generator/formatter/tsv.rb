module DummyDataGenerator
  module Formatter
    class Tsv < Base
      def params
        raise NotImplementedError.new
      end

      def delimiter
        "\t"
      end

      def labeled?
        false
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
