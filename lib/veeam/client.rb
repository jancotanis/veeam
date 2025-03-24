# frozen_string_literal: true

module Veeam
  # A client wrapper for interacting with the Veeam REST API.
  # This client provides access to various API endpoints by grouping methods into separate modules.
  #
  # @note The client follows the structure and grouping used in the official Veeam API documentation.
  #   It loads the relevant modules dynamically and provides a unified interface to interact with
  #   different parts of the Veeam API.
  #
  # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html
  #   Official Veeam REST API documentation.
  #
  # == Included Modules:
  # - {Veeam::Client::About}: Provides methods related to general API information.
  # - {Veeam::Client::Companies}: Manages companies and their resources.
  # - {Veeam::Client::Infrastructure}: Deals with infrastructure resources.
  # - {Veeam::Client::Alarms}: Handles alarm-related API calls.
  #
  # == Example Usage:
  #
  #   # Initialize the Veeam client
  #   client = Veeam::Client.new(
  #     access_token: 'your_api_token',
  #     endpoint: 'https://your-veeam-server/api/v3'
  #   )
  #
  #   # Access API methods
  #   about_info = client.get_about_info
  #   companies = client.get_companies
  #
  #   puts "Connected to Veeam API version: #{about_info['version']}"
  class Client < API
    # Require and load all client-specific modules from the 'client' folder.
    Dir[File.expand_path('client/*.rb', __dir__)].each { |lib| require lib }

    # Include individual client modules, grouping methods based on API functionality.
    include Veeam::Client::About
    include Veeam::Client::Companies
    include Veeam::Client::Infrastructure
    include Veeam::Client::Alarms
  end
end
