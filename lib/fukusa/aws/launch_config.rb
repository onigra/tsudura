require_relative "./utils"

module Fukusa::Aws
  class LaunchConfig
    include Fukusa::Aws::Utils
  
    def initialize(image_id, config, timestamp)
      @image_id = image_id
      @config = config
      @timestamp = timestamp
    end
  
    def create
      @new_launch_config = autoscaling.create_launch_configuration(
        image_id: @image_id,
        key_name: @config[:key_name],
        user_data: Base64.encode64(@config[:user_data_script]),
        instance_type: @config[:instance_type],
        security_groups: [@config[:security_group_id]],
        launch_configuration_name: "#{@config[:service]}-#{short_env}-#{@timestamp}",
      )
    end

    def delete
      autoscaling.delete_launch_configuration(launch_configuration_name: old_launch_config_name)
    end
  
    def old_launch_config_name
      tmp = []

      autoscaling.describe_launch_configurations.each_page do |i|
        tmp << i.launch_configurations.select { |item| item.launch_configuration_name =~ /#{@config[:service]}/ }
      end
  
      tmp.flatten.reject { |obj| obj.launch_configuration_name == @new_launch_config }.map(&:launch_configuration_name).first
    end
  
    private
  
    def autoscaling
      @autoscaling ||= ::Aws::AutoScaling::Client.new(region: @config[:region])
    end
  end
end
