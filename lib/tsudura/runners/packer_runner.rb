module Tsudura::Runners
  class PackerRunner
    include Tsudura::Runners::RunnerModule

    def initialize(config)
      @config = config
      @timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    end

    def run
      instance_id = launch_instance
      provision
      puts create_ami(instance_id)
      terminate_tmp_ec2_instance
    end
  end
end
