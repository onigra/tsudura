module Tsudura::Runners
  class NormalRunner
    include Tsudura::Runners::RunnerModule
    include Tsudura::Runners::RunnerModuleWithMessage

    def initialize(config)
      @config = config
      @timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    end

    def run
      launch_instance_with_m
      provision_with_m
      create_ami_with_m
      create_launch_config_with_m
      update_auto_scaling_group_with_m
      destroy_temp_objects_with_m
      puts "Success!!"
    end
  end
end
