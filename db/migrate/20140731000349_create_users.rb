class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :github_id
      t.string :github_username
      t.string :name
      t.string :gravatar_hash

      t.timestamps
    end

    add_index :users, :github_id, unique: true
  end
end
