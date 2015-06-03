module Fukusa::Aws
  module Utils
    def short_env
      Fukusa::EnvPrefix.short @config[:environment]
    end
  end
end
