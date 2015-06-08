module Tsudura::Runners
  module RunnerModule

    private
  
    def launch_instance
      puts "Launch instance"
      @ec2 = Tsudura::Aws::LaunchInstance.new(@config)
      @tmp_instance_id = @ec2.launch
      puts "\nLaunch tmp instance: #{@tmp_instance_id}"
      puts "Finish!!"
    end
  
    def provision
      puts "Start provisioning"
      Tsudura::Provisioner::Ansible.new(@config).provision!
      puts "Finish!!"
    end
  
    def create_ami
      puts "Create ami"
      @ami = Tsudura::Aws::Ami.new(@tmp_instance_id, @config, @timestamp)
      @new_image_id = @ami.create
      puts "\nNew image id: #{@new_image_id}"
      puts "Finish!!"
    end
  
    def create_launch_config
      puts "Create launch config"
      @launch_config = Tsudura::Aws::LaunchConfig.new(@new_image_id, @config, @timestamp)
      @launch_config.create
      puts "New launch config name: #{@config[:service]}-#{short_env}-#{@timestamp}"
      puts "Finish!!"
    end
    
    def update_auto_scaling_group
      puts "update auto scaling group"
      Tsudura::Aws::AutoScale.new(@config, @timestamp).update
      puts "Finish!!"
    end
  
    def destroy_temp_objects
      terminate_tmp_ec2_instance
      deregister_old_ami
      delete_old_launch_config
    end
    
    def terminate_tmp_ec2_instance
      puts "Terminate instance"
      @ec2.terminate
    end

    def deregister_old_ami
      puts "Deregister old ami"
      @ami.deregister
    end
    
    def delete_old_launch_config
      puts "Delete old launch config"
      @launch_config.delete
    end

    def short_env
      Tsudura::EnvPrefix.short @config[:environment]
    end
  end
end
