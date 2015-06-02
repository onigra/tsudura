module Fukusa
  class ConfigParser
    def initialize(yml)
      @config = YAML.load_file(yml)
    end

    def attributes
      @config.symbolize_keys
    end
  end
end
