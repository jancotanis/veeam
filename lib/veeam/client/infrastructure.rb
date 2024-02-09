module Veeam
  class Client

    # Defines methods related to infrastructure resources
    # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Backup-Servers/operation/GetBackupServers
    module Infrastructure
      # Get all backupjob reports
      def backup_servers
        get_paged('/api/v3/infrastructure/backupServers')
      end

      def backup_server(backup_id)
        get("/api/v3/infrastructure/backupServers/#{backup_id}")
      end
    end
  end
end
