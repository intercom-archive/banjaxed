require('net/http')
require('json')

class Pagerduty
  def initialize
    @pg_sub_domain = ENV['PAGERDUTY_SUBDOMAIN']
    @pg_api_key = ENV['PAGERDUTY_API_KEY']
    @pg_requester_id = ENV['PAGERDUTY_REQUESTER_ID']
  end

  def post_note(incident_id, note_content)
    if not @pg_api_key or not @pg_sub_domain or not @pg_requester_id
      return
    end

    pg_incident = PagerdutyIncident.find_by(incident_id: incident_id)
    data = {
      requester_id: @pg_requester_id,
      note: { content: note_content }
    }

    unless pg_incident.nil?
      uri = URI.parse("https://#{@pg_sub_domain}.pagerduty.com/api/v1/incidents/#{pg_incident.id}/notes")
      headers = { 'Content-Type'=>'application/json', 'Authorization'=> "Token token=#{@pg_api_key}"}
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      post = Net::HTTP::Post.new(uri.path, headers)
      response = http.request post, data.to_json
      case response
        when Net::HTTPSuccess; response.body
        else response.error!
      end
    end
  end
end