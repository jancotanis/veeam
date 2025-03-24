# frozen_string_literal: true

module Veeam
  class Client
    # Defines methods related to infrastructure resources in the Veeam REST API.
    # This module provides access to backup servers and their associated resources.
    #
    # @note All methods in this module interact with the infrastructure-related endpoints of the Veeam API.
    #
    # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Backup-Servers
    module Infrastructure
      # Fetches a paginated list of all backup servers in the infrastructure.
      #
      # This method retrieves metadata about the available backup servers.
      # It uses offset-based pagination by default.
      #
      # @return [Array<Hash>] An array of backup server data (paginated)
      #
      # @example Fetching backup servers:
      #   client = Veeam.client
      #   servers = client.backup_servers
      #   servers.each do |server|
      #     puts "Backup Server Name: #{server['name']}"
      #   end
      #
      # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Backup-Servers/operation/GetBackupServers
      def backup_servers
        get_paged('/api/v3/infrastructure/backupServers')
      end

      # Fetches details for a specific backup server.
      #
      # This method returns detailed information about a single backup server identified by its ID.
      #
      # @param backup_id [String] The unique identifier of the backup server
      # @return [Hash] Detailed information about the specified backup server
      #
      # @example Fetching a single backup server:
      #   client = Veeam.client
      #   server = client.backup_server("backup_server_id_123")
      #   puts "Backup Server Details: #{server['name']} - Status: #{server['status']}"
      #
      # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Backup-Servers
      def backup_server(backup_id)
        get("/api/v3/infrastructure/backupServers/#{backup_id}")
      end
    end
  end
end
