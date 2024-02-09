module Veeam
  class Client

    # Defines methods related to companies resource
    # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Companies/operation/GetCompanies
    module Companies
      # Get all backupjob reports
      def companies
        get_paged('/api/v3/organizations/companies')
      end

      def company(company_id)
        get("/api/v3/organizations/companies/#{company_id}")
      end
    end
  end
end
