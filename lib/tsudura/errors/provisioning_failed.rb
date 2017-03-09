module Tsudura
  module Errors
    class ProvisioningFailed < StandardError
      def message
        "Provisioning failed. Please check provisioning setting."
      end
    end
  end
end
