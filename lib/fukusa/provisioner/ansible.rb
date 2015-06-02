module Fukusa::Provisioner
  class Ansible
    def initialize(config)
      @config = config
      File.open("tmp_password_file", "w") { |f| f.puts @config[:service] }
    end
  
    def provision!
      puts 'Start provisioning'
      
      Open3.popen3("ansible-playbook #{@config[:playbook_path]} -i ~/.ansible/ec2.py --vault-password-file tmp_password_file") do |i, o, e, w|
        o.each do |line| puts line end
      end
      
      puts 'Finish provisioning'
  
      FileUtils.rm "tmp_password_file"
    end
  end
end
