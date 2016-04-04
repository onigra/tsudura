require File.expand_path(File.join('../', 'spec_helper'), File.dirname(__FILE__))

describe Tsudura::ConfigParser do
  describe "#attributes" do
    context "normal mode" do
      before do
        ENV["VAULT_PASSWORD"] = "password"
        ENV["OWNER"] = "99999999"
      end

      let(:config_obj) { described_class.new("#{APP_ROOT}/spec/samples/yamls/normal.yml") }

      it do
        expect(config_obj.attributes).to match(
          service: "tsudura",
          environment: "staging",
          region: "ap-northeast-1",
          security_group_id: "sg-2f1e854a",
          subnet_id: "subnet-cd985794",
          image_id: "ami-cbf90ecb",
          key_name: "tsudura_sample",
          playbook_path: "spec/samples/ansible_playbook/staging.yml",
          instance_type: "t2.micro",
          inventory_file: "~/.ansible/ec2.py",
          vault_password: "password",
          user_data_script: "#!/bin/bash -ex\nsu - deploy /home/deploy/startup.sh staging",
          auto_scaling_group_name: "tsudura-stg-blue",
          owner: 99999999,
          iam_instance_profile: "tsudura_role",
        )
      end
    end
  end
end
