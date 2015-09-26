module Tsudura::ConfigChecker
  class Base

    BASE_METHODS = [
      :service,
      :region,
      :security_group_id,
      :subnet_id,
      :image_id,
      :key_name,
      :instance_type,
      :playbook_path,
      :inventory_file,
      :owner
    ]

    BASE_METHODS.each do |name|
      define_method("#{name}?") { config_include_eval { __method__.to_s.gsub("?", "").to_sym } }
    end

    def initialize(config)
      @config = config
    end

    def run
      run_all_check_methods.all?
    end

    private

    def config_include_eval
      @config.include?(:"#{yield}")
    end

    def superclass_constants
      self.class.superclass.constants
    end

    def run_all_check_methods
      all_constants.map { |constant|
        Object.const_get("#{self.class.superclass}::#{constant.to_s}").map { |i| send "#{i}?" }
      }.flatten
    end

    def all_constants
      superclass_constants.concat self.class.constants
    end
  end
end
