module Veeam
	
  # Generic error to be able to rescue all Veeam errors
  class VeeamError < StandardError; end

  # Raised when Veeam not configured correctly
  class ConfigurationError < VeeamError; end

  # Error when authentication fails
  class AuthenticationError < VeeamError; end
end