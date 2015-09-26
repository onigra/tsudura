require File.expand_path(File.join('../../', 'spec_helper'), File.dirname(__FILE__))

describe Tsudura::ConfigChecker::Base do
  let(:config) { Tsudura::ConfigParser.new("#{APP_ROOT}/spec/samples/yamls/normal.yml").attributes }

  describe "#service?" do
    subject { described_class.new(config).service? }
    it { should be_truthy }
  end

  describe "#region?" do
    subject { described_class.new(config).region? }
    it { should be_truthy }
  end

  describe "#security_group_id?" do
    subject { described_class.new(config).security_group_id? }
    it { should be_truthy }
  end

  describe "#subnet_id?" do
    subject { described_class.new(config).subnet_id? }
    it { should be_truthy }
  end

  describe "#image_id?" do
    subject { described_class.new(config).image_id? }
    it { should be_truthy }
  end

  describe "#key_name?" do
    subject { described_class.new(config).key_name? }
    it { should be_truthy }
  end

  describe "instance_type#?" do
    subject { described_class.new(config).instance_type? }
    it { should be_truthy }
  end

  describe "playbook_path#?" do
    subject { described_class.new(config).playbook_path? }
    it { should be_truthy }
  end

  describe "inventory_file#?" do
    subject { described_class.new(config).inventory_file? }
    it { should be_truthy }
  end

  describe "owner#?" do
    subject { described_class.new(config).owner? }
    it { should be_truthy }
  end
end
