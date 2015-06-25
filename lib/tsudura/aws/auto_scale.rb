module Tsudura::Aws
  class AutoScale
    include Tsudura::Aws::Utils

    def initialize(config, timestamp)
      @config = config
      @timestamp = timestamp
    end
  
    def update
      autoscaling.update_auto_scaling_group(
        auto_scaling_group_name: @config[:auto_scaling_group_name],
        launch_configuration_name: "#{@config[:service]}-#{short_env}-#{@timestamp}",
      )
    end

    private

    def autoscaling
      @autoscaling ||= ::Aws::AutoScaling::Client.new(region: 'ap-northeast-1')
    end
  end
end
