class User < ActiveRecord::Base
  validates :github_id, presence: true, uniqueness: true
  validates :github_username, presence: true
end
