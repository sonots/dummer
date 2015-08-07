module Dummer
  class Generator
    class Factory
      attr_reader :setting

      def initialize(setting)
        @setting = setting
      end

      # file
      def create_message_proc
        if fields = setting.fields
          FieldMode.message_proc(
            fields,
            setting.labeled,
            setting.delimiter,
            setting.label_delimiter
          )
        elsif input = setting.input
          InputMode.message_proc(input)
        else
          MessageMode.message_proc(setting.message)
        end
      end

      # fluent-logger
      def create_record_proc
        if fields = setting.fields
          FieldMode.record_proc(fields)
        elsif input = setting.input
          InputMode.record_proc(input)
        else
          MessageMode.record_proc(setting.message)
        end
      end

      # fluent-logger
      def create_tag_proc
        FieldMode.tag_proc(setting.tag)
      end
    end
  end
end
