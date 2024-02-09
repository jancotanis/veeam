module Veeam
  class Client

    # Defines methods related to About resource
    # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/About/operation/GetAboutInformation
    module About
      # Get all backupjob reports
      def about
        get('/api/v3/about')
      end
    end
  end
end
