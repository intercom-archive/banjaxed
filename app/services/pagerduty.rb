require('net/http')

class Pagerduty
  def get_pagerduty_user
    puser = User.find_by(github_id: 766800)
    puser ? { user: puser } : { error: 'Pagerduty user does not exist. Run pagerduty:create_user task.' }
  end

  def create_or_update_incident(pagerduty_id, params)
    pincident = PagerdutyIncident.find_by(pagerduty_id: pagerduty_id)
    begin
      if not pincident # creates a new incident
        incident = Incident.new params.to_hash
        if incident.save!
          pincident = PagerdutyIncident.new(
            pagerduty_id: pagerduty_id,
            incident_id: incident[:id]
          )
          pincident.save!
        end

      elsif params[:status] == 'resolved' # resolve an existing incident
        incident = Incident.find_by(id: pincident[:incident_id])

        if incident and incident[:status] != 'resolved'
          incident.status = 'resolved'
          incident.save!
        end
      end
    rescue Exception => e
      { error: e.message }
    end
  end

  def post_note(incident_id, note_content)
    pg_sub_domain = ENV['PAGERDUTY_SUBDOMAIN']
    pg_api_key = ENV['PAGERDUTY_API_KEY']
    pg_requester_id = ENV['PAGERDUTY_REQUESTER_ID']

    if not pg_api_key or not pg_sub_domain or not pg_requester_id
      return
    end

    pg_incident = PagerdutyIncident.find_by(incident_id: incident_id)
    data = {
      requester_id: pg_requester_id,
      note: { content: note_content }
    }

    if pg_incident
      uri = URI.parse("https://#{pg_sub_domain}.pagerduty.com/api/v1/incidents/#{pg_incident.pagerduty_id}/notes")
      headers = { 'Content-Type' => 'application/json', 'Authorization' => "Token token=#{pg_api_key}" }
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      post = Net::HTTP::Post.new(uri.path, headers)
      response = http.request post, data.to_json
      case response
        when Net::HTTPSuccess; response.body
        else response.error!
      end
    else
      { error: 'No pagerduty details found for the incident' }
    end
  end
end
