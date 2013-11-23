module DummyLogGenerator
  class Setting
    attr_accessor :rate, :output, :labeled, :delimiter, :fields, :workers, :message, :input

    def initialize
      @rate = 500
      @output = STDOUT
      @labeled = true
      @delimiter = "\t"
      @fields = {}
      @workers = 1
      @message = nil
      @input = nil
    end
  end
end
