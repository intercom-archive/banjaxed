class User < ActiveRecord::Base
  validates :github_id, presence: true, uniqueness: true
  validates :github_username, presence: true

  has_many :incidents
  has_many :comments
  has_many :actions

  def self.create_or_update_from_github_user(github_user)
    self.find_or_initialize_by(github_id: github_user.id).tap do |user|
      user.update!(
        github_username: github_user.login,
        name: github_user.name,
        avatar_url: github_user.avatar_url
      )
    end
  end
end
