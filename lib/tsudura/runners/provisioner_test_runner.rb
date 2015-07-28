module Tsudura::Runners
  class ProvisionerTestRunner
    include Tsudura::Runners::RunnerModule
    include Tsudura::Runners::RunnerModuleWithMessage

    def initialize(config)
      @config = config
    end

    def run
      launch_instance_with_m
      provision_with_m
      puts "Success!!"
    end
  end
end
