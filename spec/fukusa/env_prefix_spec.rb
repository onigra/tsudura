require File.expand_path(File.join('../', 'spec_helper'), File.dirname(__FILE__))

describe Fukusa::EnvPrefix do
  describe ".short" do
    context "production" do
      subject { described_class.short "production" }
      it { should eq "prd" }
    end

    context "staging" do
      subject { described_class.short "staging" }
      it { should eq "stg" }
    end

    context "development" do
      subject { described_class.short "development" }
      it { should eq "dev" }
    end

    context "test" do
      subject { described_class.short "test" }
      it { should eq "tes" }
    end

    context "ci" do
      subject { described_class.short "ci" }
      it { should eq "ci" }
    end
  end
end
