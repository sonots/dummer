module Dummer
  class Setting
    attr_accessor :rate, :output, :labeled, :label_delimiter, :delimiter, :fields, :workers, :message, :input, :log
    attr_accessor :host, :port, :tag

    def initialize
      @rate = 500
      @output = STDOUT
      @host = nil
      @port = 24224
      @labeled = true
      @label_delimiter = ":"
      @delimiter = "\t"
      @tag = {type: :string, value: "dummer"}
      @fields = nil
      @workers = 1
      @log = '-'
      @message = "time:2013-11-25 00:23:52 +0900\tlevel:ERROR\tmethod:POST\turi:/api/v1/people\treqtime:3.1983877060667103\n"
      @input = nil
    end
  end
end
