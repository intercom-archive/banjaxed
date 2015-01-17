class AddPagerdutyIdToPagerdutyIncidents < ActiveRecord::Migration
  def change
    add_column :pagerduty_incidents, :pagerduty_id, :string
  end
end
