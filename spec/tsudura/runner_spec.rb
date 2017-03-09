require File.expand_path(File.join('..', 'spec_helper'), File.dirname(__FILE__))

describe Tsudura::Runner do
  describe ".run" do
    context "raise Tsudura::Errors::ProvisioningFailed" do
      it do
        allow(Tsudura::Runner).to receive(:run).and_raise(Tsudura::Errors::ProvisioningFailed)
        expect { Tsudura::Runner.run }.to raise_error(
          Tsudura::Errors::ProvisioningFailed, "Provisioning failed. Please check provisioning setting."
        )
      end
    end
  end
end
