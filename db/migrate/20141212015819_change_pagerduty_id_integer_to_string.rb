class ChangePagerdutyIdIntegerToString < ActiveRecord::Migration
  def change
    change_column :pagerduty_incidents, :id, :string
  end
end
