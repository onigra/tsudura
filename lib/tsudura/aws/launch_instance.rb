module Tsudura::Aws
  class LaunchInstance
  
    def initialize(config)
      @config = config
    end
  
    def launch
      launch_result = launch_ec2
      @launched_instance_id = launch_result[:instances].first.instance_id
      waiting_for_launch
      create_tag
      @launched_instance_id
    end
  
    def terminate
      ec2.terminate_instances(instance_ids: [@launched_instance_id])
    end
  
    private

    def ec2
      @ec2 ||= ::Aws::EC2::Client.new(region: @config[:region])
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

    def waiting_for_launch
      status = nil

      while (status.nil? || status == 'initializing')
        sleep 10
        statuses = ec2.describe_instance_status(instance_ids: [@launched_instance_id])

        # 早すぎるとステータスの取得すらできない
        if statuses[:instance_statuses] == []
          next
        end

        status = statuses[:instance_statuses].first[:system_status].status
      end
    end

    def create_tag
      ec2.create_tags(resources: [@launched_instance_id], tags: [ { key: 'Name', value: "#{@config[:service]}-ami"}])
    end
  end
end
