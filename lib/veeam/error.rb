# frozen_string_literal: true

module Veeam
  # Namespace for handling Veeam-specific errors.
  # This module defines custom error classes that inherit from `StandardError`,
  # allowing users to rescue specific errors related to Veeam API operations.
  #
  # == Custom Error Classes:
  # - {Veeam::VeeamError}: A generic base error class for all Veeam-related errors.
  # - {Veeam::ConfigurationError}: Raised when the client configuration is incomplete or incorrect.
  # - {Veeam::AuthenticationError}: Raised when authentication with the Veeam API fails.
  #
  # == Example Usage:
  #
  #   begin
  #     client = Veeam::Client.new(access_token: nil)
  #     client.login
  #   rescue Veeam::ConfigurationError => e
  #     puts "Configuration error: #{e.message}"
  #   rescue Veeam::AuthenticationError => e
  #     puts "Authentication failed: #{e.message}"
  #   rescue Veeam::VeeamError => e
  #     puts "An unexpected Veeam error occurred: #{e.message}"
  #   end
  #

  # Generic error to allow rescuing all Veeam-related exceptions.
  class VeeamError < StandardError; end

  # Raised when the Veeam client is not configured correctly.
  # This might happen, for example, if the required `access_token` or `endpoint` options are missing.
  #
  # @example
  #   raise Veeam::ConfigurationError, "Access token is missing" if access_token.nil?
  class ConfigurationError < VeeamError; end

  # Raised when authentication with the Veeam API fails.
  # This typically occurs when an invalid access token is used, or if API credentials are not authorized.
  #
  # @example Handling authentication failure
  #   begin
  #     client.login
  #   rescue Veeam::AuthenticationError => e
  #     puts "Authentication failed: #{e.message}"
  #   end
  class AuthenticationError < VeeamError; end
end
