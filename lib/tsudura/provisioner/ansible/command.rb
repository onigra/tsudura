module Tsudura::Provisioner
  module Ansible
    class Command
      def self.exec(config)
        Open3.popen3(CommandGenerator.new(config).generate) do |_, o, e, w|
          o.each { |line| puts line }
          e.each { |line| puts line }
          raise ::Tsudura::Errors::ProvisioningFailed unless w.value.success?
        end
      end
    end
  end
end
