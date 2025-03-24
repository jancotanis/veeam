# frozen_string_literal: true

module Veeam
  class Client
    # Defines methods related to the "About" resource in the Veeam Service Provider Console API.
    # This resource provides general information about the API and its configuration.
    #
    # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/About/operation/GetAboutInformation
    module About
      # Fetches general information about the Veeam Service Provider Console API.
      #
      # This includes API version, server time, and other configuration details.
      #
      # @return [Hash] A hash containing the "about" information from the API.
      #
      # @example Fetching information about the API:
      #   client = Veeam.client
      #   about_info = client.about
      #   puts "API Version: #{about_info['apiVersion']}"
      #   puts "Server Time: #{about_info['serverTime']}"
      #
      # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/About/operation/GetAboutInformation
      def about
        get('/api/v3/about')
      end
    end
  end
end
