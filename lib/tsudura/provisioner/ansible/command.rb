module Tsudura::Provisioner
  module Ansible
    class Command
      def self.exec(config)
        Open3.popen3(CommandGenerator.new(config).generate) do |_, stdout, stderr, wait_thr|
          stdout.each { |line| puts line }
          stderr.each { |line| puts line }
          raise ::Tsudura::Errors::ProvisioningFailed unless wait_thr.value.success?
        end
      end
    end
  end
end
