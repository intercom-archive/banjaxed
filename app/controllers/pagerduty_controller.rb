class PagerdutyController < ApplicationController
  skip_before_action :verify_authenticity_token

  def callback
    puser = User.find_by(github_id: 766800)

    # return if pagerduty:create_user task has not been run.
    unless puser
      head :ok
    end

    messages = params['messages']

    unless messages.kind_of?(Array)
      messages = [messages]
    end

    messages.each do |message|
      msg_incident = message['data']['incident']
      pincident = PagerdutyIncident.find_by(id: msg_incident['id'])

      # create banjaxed incident
      if not pincident
        incident = Incident.new
        incident.title = msg_incident['trigger_summary_data']['subject']
        incident.description = msg_incident['trigger_summary_data']['description'] || msg_incident['trigger_summary_data']['subject']
        incident.severity = 'critical'
        incident.status = msg_incident['status'] == 'triggered' ? 'open': msg_incident['status']
        incident.started_at = msg_incident['created_on']
        incident.detected_at = msg_incident['created_on']
        incident.user_id = puser['id']
        if incident.save
          pincident = PagerdutyIncident.new
          pincident.id = msg_incident['id']
          pincident.incident_id = incident['id']
          pincident.save
        end

     # resolve an existing incident
      elsif msg_incident['status'] == 'resolved'
        incident = Incident.find_by(id: pincident['incident_id'])
        if incident and incident['status'] != 'resolved'
          incident.status = 'resolved'
          incident.save
        end
      end
    end

    head :ok
  end
end