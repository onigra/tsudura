module Tsudura
  class ConfigParser
    def initialize(yml)
      require "erb"
      @config = YAML.load(ERB.new(File.read(yml)).result)
    end

    def attributes
      @config.symbolize_keys
    end

    def check
      true
    end
  end
end
