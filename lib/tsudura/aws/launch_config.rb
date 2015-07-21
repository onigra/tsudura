module Tsudura::Aws
  class LaunchConfig
    include Tsudura::Aws::Utils
  
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
      unless unavailable_launch_configurations.empty?
        unavailable_launch_configurations.each do |launch_configuration_name|
          autoscaling.delete_launch_configuration(launch_configuration_name: launch_configuration_name)
        end
      end
    end
  
    private

    def autoscaling
      @autoscaling ||= ::Aws::AutoScaling::Client.new(region: @config[:region])
    end

    def unavailable_launch_configurations
      @unavailable_launch_configurations ||= all_launch_configurations - available_launch_configurations
    end

    def available_launch_configurations
      tmp = []

      autoscaling.describe_auto_scaling_groups.each_page { |i| tmp.concat i.launch_configurations }
      tmp.select { |i| i[:launch_configuration_name] =~ /#{@config[:service]}-#{short_env}/ }.map(&:launch_configuration_name).uniq
    end

    def all_launch_configurations
      tmp = []

      autoscaling.describe_launch_configurations.each_page { |i| tmp.concat i.launch_configurations }
      tmp.select { |i| i[:launch_configuration_name] =~ /#{@config[:service]}-#{short_env}/ }.map(&:launch_configuration_name)
    end
  end
end
