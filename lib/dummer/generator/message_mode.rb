module Dummer
  class Generator
    class MessageMode < AbstractMode
      def self.message_proc(message)
        message = "#{message.chomp}\n"
        Proc.new { message }
      end

      def self.record_proc(message)
        # ToDo: implement parser
        message_proc = message_proc(message)
        Proc.new { { "message" => message_proc.call } }
      end
    end
  end
end
