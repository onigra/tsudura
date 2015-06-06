module Tsudura::Runners
  class PackerPlusRunner
    include Tsudura::Runners::RunnerModule

    def initialize(config)
      @config = config
      @timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    end

    def run
      instance_id = launch_instance
      provision
      new_image_id = create_ami(instance_id)
      create_launch_config(new_image_id)
      terminate_tmp_ec2_instance
    end
  end
end
