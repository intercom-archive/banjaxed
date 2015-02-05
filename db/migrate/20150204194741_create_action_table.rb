class CreateActionTable < ActiveRecord::Migration
  def change
    create_table :action_tables do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "user_id"
      t.string   "action_type"
      t.text     "data"

      t.timestamps
    end
  end
end
