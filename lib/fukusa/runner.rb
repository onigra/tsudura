module Fukusa
  class Runner
    def initialize(config)
      @config = config
      @timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    end
  
    def run
      instance_id = launch_instance
      provision
      new_image_id = create_ami(instance_id)
      create_launch_config(new_image_id)
      update_auto_scaling_group
      destroy_temp_objects
    end
  
    private
  
    def launch_instance
      @ec2 = Aws::LaunchInstance.new(@config)
      @ec2.launch
    end
  
    def provision
      Provisioner::Ansible.new(@config).provision!
    end
  
    def create_ami(instance_id)
      @ami = Aws::Ami.new(instance_id, @config, @timestamp)
      @ami.create
    end
  
    def create_launch_config(new_image_id)
      @launch_config = Aws::LaunchConfig.new(new_image_id, @config, @timestamp)
      @launch_config.create
    end
    
    def update_auto_scaling_group
      Aws::AutoScale.new(@config, @timestamp).update
    end
  
    def destroy_temp_objects
      @ec2.terminate
      @ami.deregister
      @launch_config.delete
    end
  end
end
