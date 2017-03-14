require File.expand_path(File.join('../../../', 'spec_helper'), File.dirname(__FILE__))

describe Tsudura::Provisioner::Ansible::CommandGenerator do
  let(:generator) { described_class.new(config) }

  describe "#generate" do
    before { ENV["OWNER"] = "99999999" }

    context "vault password無し" do
      let(:config) { Tsudura::ConfigParser.new("#{APP_ROOT}/spec/samples/yamls/has_not_vault_pass.yml").attributes }
      subject { generator.generate }
      it { should eq "ansible-playbook #{config[:playbook_path]} -i #{config[:inventory_file]}" }
    end

    context "vault password有り" do
      let(:config) { Tsudura::ConfigParser.new("#{APP_ROOT}/spec/samples/yamls/normal.yml").attributes }
      subject { generator.generate }
      it { should eq "ansible-playbook #{config[:playbook_path]} -i #{config[:inventory_file]} #{generator.send :vault_password_file_option}" }
    end
  end

  describe "#use_vault_option?" do
    context "vault password無し" do
      let(:config) { Tsudura::ConfigParser.new("#{APP_ROOT}/spec/samples/yamls/has_not_vault_pass.yml").attributes }
      subject { generator.use_vault_option? }
      it { should be_falsy }
    end

    context "vault password有り" do
      let(:config) { Tsudura::ConfigParser.new("#{APP_ROOT}/spec/samples/yamls/normal.yml").attributes }
      subject { generator.use_vault_option? }
      it { should be_truthy }
    end
  end
end
