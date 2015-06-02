module Fukusa::Aws
  class LaunchInstance
  
    def initialize(config)
      @config = config
    end
  
    def launch
      instance_result = launch_ec2
      instance = instance_result[:instances].first
      waiting_for_launch instance
      ec2.create_tags(resources: [instance.instance_id], tags: [ { key: 'Name', value: "#{@config[:service]}-ami"}])
      @launched_instance_id = instance.instance_id
      @launched_instance_id
    end
  
    def terminate
      ec2.terminate_instances(instance_ids: [@launched_instance_id])
    end
  
    private
  
    #
    # statusがreadyになるまで待ち
    #
    def waiting_for_launch(instance)
      status = nil
  
      while (status.nil? || status == 'initializing')
        sleep 10
  
        statuses = ec2.describe_instance_status(instance_ids: [instance.instance_id])
        if statuses[:instance_statuses] == []
          #  早過ぎると、ステータス取得すらできない
          next
        end
  
        status = statuses[:instance_statuses].first[:system_status].status
        puts status
      end
    end
  
    def launch_ec2
      ec2.run_instances(
        min_count: 1,
        max_count: 1,
        key_name: @config[:key_name],
        image_id: @config[:image_id],
        subnet_id: @config[:subnet_id],
        instance_type: @config[:instance_type],
        security_group_ids: [@config[:security_group_id]],
      )
    end

    def ec2
      @ec2 ||= ::Aws::EC2::Client.new(region: @config[:region])
    end
  end
end
