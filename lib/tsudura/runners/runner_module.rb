module Tsudura::Runners
  module RunnerModule

    private
  
    def launch_instance
      @ec2 = Tsudura::Aws::LaunchInstance.new(@config)
      @ec2.launch
    end
  
    def provision
      Tsudura::Provisioner::Ansible.new(@config).provision!
    end
  
    def create_ami(instance_id)
      @ami = Tsudura::Aws::Ami.new(instance_id, @config, @timestamp)
      @ami.create
    end
  
    def create_launch_config(new_image_id)
      @launch_config = Tsudura::Aws::LaunchConfig.new(new_image_id, @config, @timestamp)
      @launch_config.create
    end
    
    def update_auto_scaling_group
      Tsudura::Aws::AutoScale.new(@config, @timestamp).update
    end
  
    def destroy_temp_objects
      @ec2.terminate
      @ami.deregister
      @launch_config.delete
    end
    
    def terminate_tmp_ec2_instance
      @ec2.terminate
    end

    def deregister_old_ami
      @ami.deregister
    end
    
    def delete_old_launch_config
      @launch_config.delete
    end
  end
end
