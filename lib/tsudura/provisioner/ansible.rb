module Tsudura::Provisioner
  class Ansible
    def initialize(config)
      @config = config
    end
  
    def provision!
      command = base_command

      if use_vault_option?
        command << add_vault_option
      end

      Open3.popen3 command do |i, o, e, w|
        o.each do |line| puts line end
      end
    ensure
      remove_vault_password_file if use_vault_option?
    end

    private

    def base_command
      "ansible-playbook #{@config[:playbook_path]} -i #{@config[:inventory_file]}"
    end

    def use_vault_option?
      @config[:vault_password] ? true : false
    end

    def add_vault_option
      create_vault_password_file
      vault_option
    end

    def vault_option
      " --vault-password-file tmp_password_file"
    end

    def create_vault_password_file
      File.open("tmp_password_file", "w") { |f| f.puts @config[:vault_password] }
    end

    def remove_vault_password_file
      FileUtils.rm "tmp_password_file"
    end
  end
end
