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
      ec2.deregister_image(image_id: get_old_image(describe_service_images))
    end

    def describe_service_images 
      ec2.describe_images(owners: ["#{@config[:owner]}"], filters: [ { name: "name", values: ["#{@config[:service]}-#{short_env}*"] }])
    end

    def get_old_image(images)
      old_image_id = nil
      images.each_page { |i| old_image_id = i.images.map(&:image_id).reject { |id| id == @new_image_id }.first }
      old_image_id
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
  
      while (status.nil? || status == 'pending')
        sleep 10
        status = ec2.describe_images(image_ids: [@new_image_id])[:images].first.state
      end
    end

    def ec2
      @ec2 ||= ::Aws::EC2::Client.new(region: @config[:region])
    end
  end
end
