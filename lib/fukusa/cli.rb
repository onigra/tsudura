module Fukusa
  class CLI < Thor
    desc "build", "Create new ami and update auto scaling group and delete old ami and launch config."
    def build(yml)
      config = ConfigParser.new yml
      Runner.new(config.attributes).run
    end
  end
end
