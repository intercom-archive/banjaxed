class User < ActiveRecord::Base
  validates :github_id, presence: true, uniqueness: true
  validates :github_username, presence: true

  def self.create_or_update_from_github_user(github_user)
    self.where(github_id: github_user.id).first_or_create!(
      github_username: github_user.login,
      name: github_user.name,
      gravatar_hash: github_user.gravatar_id
    )
  end
end
