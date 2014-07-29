class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.string :title
      t.text :description
      t.string :severity
      t.string :status, default: 'open'
      t.datetime :started_at
      t.datetime :detected_at

      t.timestamps
    end
  end
end
