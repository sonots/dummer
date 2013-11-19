module DummyLogGenerator
  class Setting
    attr_accessor :rate, :output, :labeled, :delimiter, :fields

    def initialize
      @rate = 500
      @output = STDOUT
      @labeled = true
      @delimiter = "\t"
      @fields = {}
    end
  end
end
