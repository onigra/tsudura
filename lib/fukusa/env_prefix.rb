module Fukusa
  class EnvPrefix
    def self.short(env)
      case env
      when "production"
        "prd"
      when "staging"
        "stg"
      else
        if env.size > 3
          env.slice(0, 3)
        else
          env
        end
      end
    end
  end
end
