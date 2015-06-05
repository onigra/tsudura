module Fukusa
  class Runner
    def self.run(config)
      if config.has_key?(:mode)
        Object.const_get(config[:mode].split("_").map(&:capitalize).join).new(config).run
      else
        NormalRunner.new(config).run
      end
    end
  end
end
