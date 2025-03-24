# frozen_string_literal: true

require File.expand_path('error', __dir__)

module Veeam
  # This module handles the authentication flow for the Veeam API.
  # It includes logic to check for an access token, authenticate against the Veeam portal,
  # and handle authentication errors.
  module Authentication
    # Logs in to the Veeam portal by checking the presence of an access token and
    # performing an API call to validate the token.
    # The API endpoint used for the token check is `/api/v3/about`.
    #
    # @param _options [Hash] Unused options hash (reserved for future use).
    # @raise [ConfigurationError] If the `access_token` is not set.
    # @raise [AuthenticationError] If the authentication fails (e.g., due to an invalid or expired token).
    #
    # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Authentication
    #   Veeam REST API reference for authentication.
    #
    # == Example Usage:
    #
    #   # Assuming `access_token` is properly configured in global settings:
    #   begin
    #     login # Performs a token validation check by hitting `/api/v3/about`.
    #   rescue Veeam::AuthenticationError => e
    #     puts "Authentication failed: #{e.message}"
    #   end
    def login(_options = {})
      raise ConfigurationError, 'Accesstoken/api-key not set' unless access_token

      # Only a bearer token is required for authentication.
      # Performs a sanity check by calling the Veeam API endpoint to ensure the token is valid.
      get('/api/v3/about')
    rescue Faraday::UnauthorizedError => e
      raise AuthenticationError, "Unauthorized; response #{e}"
    end
  end
end
