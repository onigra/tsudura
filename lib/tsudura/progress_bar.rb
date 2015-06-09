module Tsudura
  class ProgressBar
    def initialize
      @num = 1
    end

    def write
      @num += 1
      print "\rWaiting...#{'.' * @num}"
      STDOUT.flush
    end
  end
end
