
module Veeam
  # Deals with authentication flow and stores it within global configuration
  module Authentication

    # https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Authentication
    # Authorize to the Veeam portal and return access_token
    def login(options = {})
      raise ArgumentError, "Accesstoken/api-key not set" unless access_token
      # only bearer token needed 
      # will do sanitty check if token if valid
      get("/api/v3/about")
    end

  end
end
