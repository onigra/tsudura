module Tsudura::Provisioner
  module Ansible
    class Command
      def self.exec(config)
        Tsudura::Provisioner::Executer.run CommandGenerator.new(config).generate
      end
    end
  end
end
