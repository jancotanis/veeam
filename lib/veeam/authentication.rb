require File.expand_path('error', __dir__)

module Veeam
  # Deals with authentication flow and stores it within global configuration
  module Authentication

    # https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Authentication
    # Authorize to the Veeam portal and return access_token
    def login(options = {})
      raise ConfigurationError, "Accesstoken/api-key not set" unless access_token
      # only bearer token needed 
      # will do sanitty check if token if valid
      get("/api/v3/about")
    rescue Faraday::UnauthorizedError  => e

      raise AuthenticationError.new 'Unauthorized; response ' + e.to_s
    end

  end
end
