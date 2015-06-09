module Tsudura::Runners
  class NormalRunner
    include Tsudura::Runners::RunnerModule
    include Tsudura::Runners::RunnerModuleWithMessage

    def initialize(config)
      @config = config
      @timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    end

    def run
      launch_instance
      provision
      create_ami
      create_launch_config
      update_auto_scaling_group
      destroy_temp_objects
      puts "Success!!"
    end
  end
end
