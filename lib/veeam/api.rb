# frozen_string_literal: true

require 'wrapi'
require File.expand_path('authentication', __dir__)

module Veeam
  # This class represents the core Veeam API client, which manages API configuration,
  # authentication, connections, and requests. It inherits configuration options from
  # the `WrAPI` module and allows additional options to be set during initialization.
  class API
    # Defines accessor methods for all configuration options from `WrAPI::Configuration`.
    # These options may include keys such as `:endpoint`, `:user_agent`, or `:connection_options`.
    attr_accessor(*WrAPI::Configuration::VALID_OPTIONS_KEYS)

    # Creates a new instance of the Veeam API client and initializes it with
    # configuration options. By default, it inherits settings from the `Veeam` singleton.
    #
    # @param options [Hash] Configuration options to customize the API client.
    #   - Options not explicitly provided are merged with the default settings from `Veeam.options`.
    #
    # == Example Usage:
    #
    #   # Create an API instance with default settings:
    #   api = Veeam::API.new
    #
    #   # Create an API instance with a custom endpoint:
    #   api = Veeam::API.new(endpoint: 'https://api.veeam.example.com')
    def initialize(options = {})
      options = Veeam.options.merge(options) # Merge custom options with default Veeam options
      WrAPI::Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key]) # Set each configuration option dynamically
      end
    end

    # Returns the current configuration as a hash, with each key-value pair
    # representing a configuration setting.
    #
    # @return [Hash] The current API configuration.
    #
    # == Example Usage:
    #
    #   api = Veeam::API.new
    #   api.config # => { endpoint: "https://default.endpoint.com", user_agent: "Veeam API", ... }
    def config
      conf = {}
      WrAPI::Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send key # Collect the current configuration into a hash
      end
      conf
    end

    # Includes additional modules that extend the functionality of the API client:
    # - `WrAPI::Connection`: Manages HTTP connections.
    # - `WrAPI::Request`: Provides methods for making API requests.
    # - `WrAPI::Authentication`: Handles authentication logic.
    # - `Veeam::Authentication`: Adds Veeam-specific authentication features.
    include WrAPI::Connection
    include WrAPI::Request
    include WrAPI::Authentication
    include Authentication
  end
end
