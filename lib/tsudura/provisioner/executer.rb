module Tsudura::Provisioner
  class Executer
    def self.run(command)
      Open3.popen3(command) do |_, stdout, stderr, wait_thr|
        stdout.each { |line| puts line }
        stderr.each { |line| puts line }
        raise ::Tsudura::Errors::ProvisioningFailed unless wait_thr.value.success?
      end
    end
  end
end
