module Tsudura
  class ProgressBar
    def initialize
      @num = 1
    end

    def write
      @num += 1
      print "working...#{'.' * @num}\r"
      STDOUT.flush
    end
  end
end
