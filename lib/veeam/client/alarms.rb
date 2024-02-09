module Veeam
  class Client

    # Defines methods related to alarm resources
    # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html?ver=80#tag/Alarms/operation/GetAlarms
    module Alarms
      # Returns collection resource representation of all Veeam Service Provider Console triggered alarms.
      def active_alarms
        get_paged('/api/v3/alarms/active')
      end
      alias all_triggered_alarms active_alarms

      # Returns a resource representation of a triggered alarm with the specified UID.
      def active_alarm(alarm_id)
        get("/api/v3/alarms/active/#{alarm_id}")
      end
      alias triggered_alarm active_alarm

      # Returns a collection resource representation of all status changes of a triggered alarm with the 
      # specified UID in chronological order.
      def alarm_history(alarm_id)
        get_paged("/api/v3/alarms/active#{alarm_id}/history")
      end
      alias triggered_alarm_history alarm_history

      # Returns a collection resource representation of all Veeam Service Provider Console alarm templates.
      def alarm_templates
        get_paged('/api/v3/alarms/templates')
      end
      alias all_alarm_templates alarm_templates

      # Returns a resource representation of a triggered alarm with the specified UID.
      def alarm_template(template_id)
        get("/api/v3/alarms/templates/#{template_id}")
      end

      # Returns all status changes of a triggered alarm with the specified template UID.
      def alarm_template_events(template_id)
        get_paged("/api/v3/alarms/templates/#{template_id}/events")
      end
      alias alarm_status_changes alarm_template_events

    end
  end
end
