class ChangeActionColumn < ActiveRecord::Migration
  def change
    rename_table :action_tables, :actions
    add_column :actions, :incident_id, :integer
  end
end
