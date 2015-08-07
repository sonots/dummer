module Dummer
  class Generator
    def initialize(setting)
      factory = Factory.new(setting)
      # fluent-logger
      @tag_proc = factory.create_tag_proc
      @record_proc = factory.create_record_proc
      # file
      @message_proc = factory.create_message_proc
    end

    # @return [String] message
    def message
      @message_proc.call
    end

    # @return [String] tag
    def tag
      @tag_proc.call
    end

    # @return [Hash] record
    def record
      @record_proc.call
    end
  end
end
