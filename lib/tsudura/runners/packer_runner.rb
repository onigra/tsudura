module Tsudura::Runners
  class PackerRunner
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
      terminate_tmp_ec2_instance_with_m
      puts "Success!!"
    end
  end
end
