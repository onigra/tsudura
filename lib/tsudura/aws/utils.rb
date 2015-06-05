module Tsudura::Aws
  module Utils
    def short_env
      Tsudura::EnvPrefix.short @config[:environment]
    end
  end
end
