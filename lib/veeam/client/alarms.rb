# frozen_string_literal: true

module Veeam
  class Client
    # Defines methods related to alarm resources in the Veeam Service Provider Console (VSPC).
    # These methods provide access to triggered alarms, their history, and alarm templates.
    #
    # @note The methods in this module correspond to endpoints described in the Veeam REST API documentation.
    # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Alarms
    module Alarms
      # Retrieves a paginated collection of all triggered alarms in the Veeam Service Provider Console.
      #
      # @return [Array<Hash>] An array of triggered alarm data.
      #
      # @example Fetching all active alarms:
      #   client = Veeam.client
      #   alarms = client.active_alarms
      #   alarms.each do |alarm|
      #     puts "Alarm: #{alarm['name']} - Severity: #{alarm['severity']}"
      #   end
      #
      # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Alarms/operation/GetAlarms
      def active_alarms
        get_paged('/api/v3/alarms/active')
      end
      alias all_triggered_alarms active_alarms

      # Fetches details of a specific triggered alarm by its unique ID.
      #
      # @param alarm_id [String] The unique identifier of the triggered alarm.
      # @return [Hash] Detailed information about the specified alarm.
      #
      # @example Fetching a specific alarm:
      #   client = Veeam.client
      #   alarm = client.active_alarm("alarm_id_123")
      #   puts "Alarm Name: #{alarm['name']} - Trigger Time: #{alarm['triggerTime']}"
      #
      # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Alarms
      def active_alarm(alarm_id)
        get("/api/v3/alarms/active/#{alarm_id}")
      end
      alias triggered_alarm active_alarm

      # Retrieves a paginated collection of all status changes of a triggered alarm.
      # The results are presented in chronological order.
      #
      # @param alarm_id [String] The unique identifier of the triggered alarm.
      # @return [Array<Hash>] An array of alarm status changes.
      #
      # @example Fetching alarm history:
      #   client = Veeam.client
      #   history = client.alarm_history("alarm_id_123")
      #   history.each do |event|
      #     puts "Status: #{event['status']} - Time: #{event['timestamp']}"
      #   end
      #
      # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Alarms
      def alarm_history(alarm_id)
        get_paged("/api/v3/alarms/active#{alarm_id}/history")
      end
      alias triggered_alarm_history alarm_history

      # Retrieves a paginated collection of all alarm templates in the Veeam Service Provider Console.
      #
      # @return [Array<Hash>] An array of alarm template data.
      #
      # @example Fetching alarm templates:
      #   client = Veeam.client
      #   templates = client.alarm_templates
      #   templates.each do |template|
      #     puts "Template: #{template['name']} - Description: #{template['description']}"
      #   end
      #
      # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Alarms/operation/GetAlarmTemplates
      def alarm_templates
        get_paged('/api/v3/alarms/templates')
      end
      alias all_alarm_templates alarm_templates

      # Fetches details of a specific alarm template by its unique template ID.
      #
      # @param template_id [String] The unique identifier of the alarm template.
      # @return [Hash] Detailed information about the specified template.
      #
      # @example Fetching a specific alarm template:
      #   client = Veeam.client
      #   template = client.alarm_template("template_id_456")
      #   puts "Template Name: #{template['name']} - Severity: #{template['severity']}"
      #
      # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Alarms
      def alarm_template(template_id)
        get("/api/v3/alarms/templates/#{template_id}")
      end

      # Retrieves all status changes for a triggered alarm with the specified template ID.
      #
      # @param template_id [String] The unique identifier of the alarm template.
      # @return [Array<Hash>] An array of alarm events related to the specified template.
      #
      # @example Fetching alarm template events:
      #   client = Veeam.client
      #   events = client.alarm_template_events("template_id_456")
      #   events.each do |event|
      #     puts "Event Status: #{event['status']} - Event Time: #{event['timestamp']}"
      #   end
      #
      # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Alarms
      def alarm_template_events(template_id)
        get_paged("/api/v3/alarms/templates/#{template_id}/events")
      end
      alias alarm_status_changes alarm_template_events
    end
  end
end
