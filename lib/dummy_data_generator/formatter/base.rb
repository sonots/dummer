module DummyDataGenerator
  module Formatter
    class NotImplementedError < StandardError; end

    class Base
      def initialize
      end

      def params
        raise NotImplementedError.new
      end

      def delimiter
        raise NotImplementedError.new
      end

      def labeled?
        raise NotImplementedError.new
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
