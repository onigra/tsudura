module Tsudura::Runners
  module RunnerModuleWithMessage

    private
  
    def launch_instance_with_m
      puts "Launch instance"
      launch_instance
      puts "\nLaunch tmp instance: #{@tmp_instance_id}"
      puts "Finish!!"
    end
  
    def provision_with_m
      puts "Start provisioning"
      provision
      puts "Finish!!"
    end
  
    def create_ami_with_m
      puts "Create ami"
      create_ami
      puts "\nNew image id: #{@new_image_id}"
      puts "Finish!!"
    end
  
    def create_launch_config_with_m
      puts "Create launch config"
      create_launch_config
      puts "New launch config name: #{@config[:service]}-#{short_env}-#{@timestamp}"
      puts "Finish!!"
    end
    
    def update_auto_scaling_group_with_m
      puts "update auto scaling group"
      update_auto_scaling_group
      puts "Finish!!"
    end
  
    def destroy_temp_objects_with_m
      terminate_tmp_ec2_instance_with_m
      delete_old_launch_config_with_m
      deregister_old_ami_with_m
    end
    
    def terminate_tmp_ec2_instance_with_m
      puts "Terminate instance"
      terminate_tmp_ec2_instance
    end

    def deregister_old_ami_with_m
      puts "Deregister old ami"
      deregister_old_ami
    end
    
    def delete_old_launch_config_with_m
      puts "Delete old launch config"
      delete_old_launch_config
    end

    def short_env
      Tsudura::EnvPrefix.short @config[:environment]
    end
  end
end
