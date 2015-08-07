module Dummer
  class Generator
    class InputMode < AbstractMode
      def self.message_proc(input)
        messages = nil
        begin
          open(input) do |in_file|
            messages = in_file.readlines
          end
        rescue Errno::ENOENT
          raise ConfigError.new("Input file `#{input}` is not readable")
        end
        idx = -1
        size = messages.size
        Proc.new {
          idx = (idx + 1) % size
          messages[idx]
        }
      end

      def self.record_proc(input)
        # ToDo: implement parser
        message_proc = message_proc(input)
        Proc.new { { "message" => message_proc.call } }
      end
    end
  end
end
