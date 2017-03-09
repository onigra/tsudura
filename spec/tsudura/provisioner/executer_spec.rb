require File.expand_path(File.join('../../', 'spec_helper'), File.dirname(__FILE__))

describe Tsudura::Provisioner::Executer do
  describe '.run' do
    context "exit status 0" do
      it "output to stdout" do
        expect { described_class.run "echo tsudura" }.to output("tsudura\n").to_stdout
      end
    end

    context "exit status 2" do
      it "output to stdout" do
        expect { described_class.run "ls ..." rescue nil }.to output(/ls: cannot access '...': No such file or directory/).to_stdout
      end

      it "raise ProvisioningFailed error" do
        expect { described_class.run "ls ..." }.to raise_error Tsudura::Errors::ProvisioningFailed
      end
    end
  end
end
