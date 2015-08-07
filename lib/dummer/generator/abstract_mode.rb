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

      # fluent-logger
      def self.tag_proc(tag_opts)
        FieldMode.field_procs({"tag" => tag_opts})["tag"]
      end
    end
  end
end
