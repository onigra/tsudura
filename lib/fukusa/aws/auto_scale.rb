module Fukusa::Aws
  class AutoScale

    def initialize(config, timestamp)
      @config = config
      @timestamp = timestamp
    end
  
    def update
      autoscaling.update_auto_scaling_group(
        auto_scaling_group_name: "#{@config[:service]}-#{@conifg[:environment]}-group",
        launch_configuration_name: "#{@config[:service]}-#{@config[:environment]}-#{@timestamp}",
      )
    end

    private

    def autoscaling
      @autoscaling ||= ::Aws::AutoScaling::Client.new(region: 'ap-northeast-1')
    end
  end
end
