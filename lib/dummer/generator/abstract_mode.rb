module Dummer
  class Generator
    class AbstractMode
      # file
      def self.message_proc(message)
        raise NotImplementedError
      end

      # fluent-logger
      def self.record_proc(message)
        raise NotImplementedError
      end
    end
  end
end
