class PagerdutyController < ApplicationController
  skip_before_action :verify_authenticity_token

  def callback
    pg = Pagerduty.new

    result = pg.get_pagerduty_user
    if result.has_key?(:error)
      head :unprocessable_entity
      return
    end

    messages = params['messages']
    unless messages.kind_of?(Array)
      messages = [messages]
    end

    messages.each do |message|
      incident = message['data']['incident']
      data = {
        title: incident['trigger_summary_data']['subject'],
        description: incident['trigger_summary_data']['description'] || incident['trigger_summary_data']['subject'],
        severity: 'critical',
        status: incident['status'] == 'triggered' ? 'open': incident['status'],
        started_at: incident['created_on'],
        detected_at: incident['created_on'],
        user_id: result[:user].id
      }
      pg.create_or_update_incident(incident['id'], data)
    end

    head :ok
  end
end
