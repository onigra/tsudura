require File.expand_path(File.join('../../../', 'spec_helper'), File.dirname(__FILE__))

describe Tsudura::Provisioner::Ansible::CommandGenerator do
  let(:config) { Tsudura::ConfigParser.new("#{APP_ROOT}/spec/samples/yamls/normal.yml").attributes }
  before { ENV["VAULT_PASSWORD"] = nil }
  after { ENV["VAULT_PASSWORD"] = nil }

  describe "#generate" do
    let(:generator) { described_class.new(config) }
    before { ENV["OWNER"] = "99999999" }

    context "vault password無し" do
      subject { generator.generate }
      it { should eq "ansible-playbook #{config[:playbook_path]} -i #{config[:inventory_file]}" }
    end

    context "vault password有り" do
      let(:generator) { described_class.new(config) }
      before { ENV["VAULT_PASSWORD"] = "password" }

      subject { generator.generate }
      it { should eq "ansible-playbook #{config[:playbook_path]} -i #{config[:inventory_file]} #{generator.send :vault_password_file_option}" }
    end
  end

  describe "#use_vault_option?" do
    let(:generator) { described_class.new(config) }

    context "vault password無し" do
      subject { generator.use_vault_option? }
      it { should be_falsy }
    end

    context "vault password有り" do
      before { ENV["VAULT_PASSWORD"] = "password" }
      subject { generator.use_vault_option? }
      it { should be_truthy }
    end
  end
end
