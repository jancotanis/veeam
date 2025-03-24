# frozen_string_literal: true

require 'wrapi'
require File.expand_path('veeam/version', __dir__)
require File.expand_path('veeam/pagination', __dir__)
require File.expand_path('veeam/api', __dir__)
require File.expand_path('veeam/client', __dir__)

# Main module for the Veeam Ruby API wrapper.
# This module extends `WrAPI::Configuration` and `WrAPI::RespondTo` to provide configurable
# API client settings and response-handling functionality.
module Veeam
  extend WrAPI::Configuration
  extend WrAPI::RespondTo

  # Default User-Agent string used in API requests.
  # This helps identify the client when making API calls.
  DEFAULT_UA = "Veeam Ruby API wrapper #{Veeam::VERSION}"

  # Default connection options.
  # These options modify the request headers, particularly to set the User-Agent.
  # The `Accept` header from `WrAPI` defaults is removed to avoid conflicts.
  DEFAULT_OPTIONS = { headers: { 'User-Agent': DEFAULT_UA } }.freeze

  # Default pagination class.
  # This class handles paginated API responses, specifically through `PagingInfoPager`.
  DEFAULT_PAGINATION = RequestPagination::PagingInfoPager

  # Create a new instance of the Veeam API client.
  #
  # This method serves as an alias for `Veeam::Client.new` and initializes the client with:
  # - Custom User-Agent.
  # - Default connection options.
  # - A default pagination class for handling paginated results.
  #
  # @param options [Hash] Optional parameters to customize the client.
  #   - `:connection_options` [Hash] Connection options, e.g., custom headers.
  #   - `:user_agent` [String] Override the default User-Agent.
  #   - `:pagination_class` [Class] Specify a different pagination handler.
  # @return [Veeam::Client] A new instance of the Veeam client.
  #
  # == Example Usage:
  #   # Create a client with default settings:
  #   client = Veeam.client
  #
  #   # Create a client with custom headers:
  #   client = Veeam.client(connection_options: { headers: { 'Authorization': 'Bearer TOKEN' } })
  def self.client(options = {})
    Veeam::Client.new({
      connection_options: DEFAULT_OPTIONS,
      user_agent: DEFAULT_UA,
      pagination_class: DEFAULT_PAGINATION
    }.merge(options))
  end

  # Reset the Veeam API client to its default configuration.
  #
  # This method resets:
  # - The API endpoint.
  # - The User-Agent string.
  # - Connection options.
  # - The pagination class.
  #
  # @return [void]
  #
  # == Example Usage:
  #   Veeam.reset
  #   # All client settings are now reset to default values.
  def self.reset
    super
    self.endpoint = nil
    self.user_agent = DEFAULT_UA
    self.connection_options = DEFAULT_OPTIONS
    self.pagination_class = DEFAULT_PAGINATION
  end
end
