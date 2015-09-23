module Tsudura::Provisioner
  module Ansible
    class CommandGenerator
      def initialize(config)
        @config = config
      end

      def generate
         exec_command = []
         exec_command << base_command
         exec_command << vault_option if use_vault_option?
         exec_command.join(" ")
      end

      def use_vault_option?
        @config[:vault_password] ? true : false
      end

      private

      def base_command
        "ansible-playbook #{@config[:playbook_path]} -i #{@config[:inventory_file]}"
      end

      def vault_option
        create_vault_password_file
        vault_password_file_option
      end

      def create_vault_password_file
        tmp_password_file << @config[:vault_password]
        tmp_password_file.close
      end

      def vault_password_file_option
        "--vault-password-file #{tmp_password_file.path}"
      end

      def tmp_password_file
        @tmp_password_file ||= Tempfile.new("tsudura.#{@config[:service]}")
      end
    end
  end
end
