class CreatePagerdutyIncidents < ActiveRecord::Migration
  def change
    create_table :pagerduty_incidents do |t|
      t.references :incident, index: true
      t.string :pagerduty_id
    end
  end
end
