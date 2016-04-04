module Tsudura::Provisioner
  module Ansible
    class Command
      def self.exec(config)
        Open3.popen3(CommandGenerator.new(config).generate) do |i, o, e, w|
          o.each do |line| puts line end
        end
      end
    end
  end
end
