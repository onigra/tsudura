module Tsudura
  class Runner
    def self.run(config)
      if config.has_key?(:mode)
        Object.const_get("Tsudura").const_get("Runners").const_get("#{config[:mode].split("_").map(&:capitalize).join}Runner").new(config).run
      else
        Tsudura::Runners::NormalRunner.new(config).run
      end
    end
  end
end
