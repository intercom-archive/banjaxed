class ReplaceGravatarHashWithAvatarUrl < ActiveRecord::Migration
  def up
    change_table :users, bulk: true do |t|
      t.remove :gravatar_hash
      t.string :avatar_url
    end
  end

  def down
    change_table :users, bulk: true do |t|
      t.remove :avatar_url
      t.string :gravatar_hash
    end
  end
end
