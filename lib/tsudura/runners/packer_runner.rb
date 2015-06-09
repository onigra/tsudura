module Tsudura::Runners
  class PackerRunner
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
      terminate_tmp_ec2_instance
    end
  end
end
