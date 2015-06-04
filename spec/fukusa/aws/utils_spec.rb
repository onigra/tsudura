require File.expand_path(File.join('../..', 'spec_helper'), File.dirname(__FILE__))

describe "Fukusa::Aws::Utils" do
  describe ".short" do
    before do
      @obj = Class.new
      @obj.extend Fukusa::Aws::Utils
    end

    context "production" do
      before { @obj.instance_variable_set(:@config, { environment: "production" }) }
      subject { @obj.short_env }
      it { should eq "prd" }
    end

    context "staging" do
      before { @obj.instance_variable_set(:@config, { environment: "staging" }) }
      subject { @obj.short_env }
      it { should eq "stg" }
    end

    context "development" do
      before { @obj.instance_variable_set(:@config, { environment: "development" }) }
      subject { @obj.short_env }
      it { should eq "dev" }
    end

    context "test" do
      before { @obj.instance_variable_set(:@config, { environment: "test" }) }
      subject { @obj.short_env }
      it { should eq "tes" }
    end

    context "ci" do
      before { @obj.instance_variable_set(:@config, { environment: "ci" }) }
      subject { @obj.short_env }
      it { should eq "ci" }
    end
  end
end
