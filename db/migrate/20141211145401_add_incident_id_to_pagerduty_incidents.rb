class AddIncidentIdToPagerdutyIncidents < ActiveRecord::Migration
  def change
    add_reference :pagerduty_incidents, :incident, index: true
  end
end
