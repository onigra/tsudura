module Tsudura::Aws
  class Ami
    include Tsudura::Aws::Utils
  
    def initialize(instance_id, config, timestamp)
      @instance_id = instance_id
      @config = config
      @timestamp = timestamp
    end
  
    def create
      @new_image_id = create_ami
      waiting_for_available
      @new_image_id
    end
     
    def deregister
      unless not_use_images.empty?
        not_use_images.each do |image_id|
          ec2.deregister_image(image_id: image_id)
        end
      end
    end

    private

    def create_ami
      result = ec2.create_image(name: "#{@config[:service]}-#{short_env}-#{@timestamp}", instance_id: @instance_id)
      result[:image_id]
    end

    #
    # stateがavailableになるまで待ち
    #
    def waiting_for_available
      status = nil
      progress = Tsudura::ProgressBar.new
  
      while (status.nil? || status == 'pending')
        sleep 10
        status = ec2.describe_images(image_ids: [@new_image_id])[:images].first.state
        progress.write
      end
    end

    def ec2
      @ec2 ||= ::Aws::EC2::Client.new(region: @config[:region])
    end

    def launch_config
      @launch_config ||= ::Aws::AutoScaling::Client.new(region: @config[:region])
    end

    def not_use_images
      @not_use_images ||= all_images - available_images
    end

    def all_images
      tmp = []

      ec2.describe_images(
        owners: ["#{@config[:owner]}"],
        filters: [ { name: "name", values: ["#{@config[:service]}-#{short_env}*"] }]
      ).each_page { |i| tmp.concat i.images }

      tmp.map(&:image_id)
    end

    def available_images
      tmp = []

      launch_config.describe_launch_configurations.each_page { |i| tmp.concat i.launch_configurations }
      tmp.select { |i| i[:launch_configuration_name] =~ /#{@config[:service]}-#{short_env}/ }.map(&:image_id).uniq
    end
  end
end
