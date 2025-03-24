# frozen_string_literal: true
module Veeam
  class Client
    # Defines methods related to the companies resource in the Veeam REST API.
    # This module provides access to operations that manage and retrieve company information.
    #
    # @note These methods interact with the "Companies" endpoints of the Veeam API.
    # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Companies
    module Companies
      # Fetches a paginated list of all companies.
      #
      # This method retrieves metadata about all companies associated with the Veeam instance.
      # It uses offset-based pagination by default to handle large datasets.
      #
      # @return [Array<Hash>] An array of company data (paginated).
      #
      # @example Fetching all companies:
      #   client = Veeam.client
      #   companies = client.companies
      #   companies.each do |company|
      #     puts "Company Name: #{company['name']} - Status: #{company['status']}"
      #   end
      #
      # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Companies/operation/GetCompanies
      def companies
        get_paged('/api/v3/organizations/companies')
      end

      # Fetches details of a specific company by its unique ID.
      #
      # This method returns detailed information about a single company identified by the given `company_id`.
      #
      # @param company_id [String] The unique identifier of the company.
      # @return [Hash] Detailed information about the specified company.
      #
      # @example Fetching a specific company:
      #   client = Veeam.client
      #   company = client.company("company_id_456")
      #   puts "Company Details: #{company['name']} - Location: #{company['location']}"
      #
      # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Companies
      def company(company_id)
        get("/api/v3/organizations/companies/#{company_id}")
      end
    end
  end
end
