require File.expand_path(File.join('../../', 'spec_helper'), File.dirname(__FILE__))

describe Tsudura::Aws::LaunchConfig do
  describe "#options" do
    let(:image_id) { "ami-cbf90ecb" }
    let(:timestamp) { Time.now.strftime('%Y%m%d%H%M%S') }

    context "iam_instance_profile有り" do
      let(:config) { Tsudura::ConfigParser.new("#{APP_ROOT}/spec/samples/yamls/normal.yml").attributes }

      subject { described_class.new(image_id, config, timestamp).options }

      it do
        should eq(
          {
            image_id: image_id,
            key_name: config[:key_name],
            user_data: Base64.encode64(config[:user_data_script]),
            instance_type: config[:instance_type],
            security_groups: [config[:security_group_id]],
            launch_configuration_name: "#{config[:service]}-stg-#{timestamp}",
            iam_instance_profile: "tsudura_role",
          }
        )
      end
    end

    context "iam_instance_profile無し" do
      let(:config) { Tsudura::ConfigParser.new("#{APP_ROOT}/spec/samples/yamls/has_not_iam_instance_profile.yml").attributes }

      subject { described_class.new(image_id, config, timestamp).options }

      it do
        should eq(
          {
            image_id: image_id,
            key_name: config[:key_name],
            user_data: Base64.encode64(config[:user_data_script]),
            instance_type: config[:instance_type],
            security_groups: [config[:security_group_id]],
            launch_configuration_name: "#{config[:service]}-stg-#{timestamp}",
          }
        )
      end
    end
  end
end
