module Fukusa
  class Runner
    def self.run(config)
      if config.has_key?(:mode)
        Object.const_get("Fukusa").const_get("#{config[:mode].split("_").map(&:capitalize).join}Runner").new(config).run
      else
        Fukusa::NormalRunner.new(config).run
      end
    end
  end
end
