class Comment < ActiveRecord::Base
  validates :incident, presence: true
  validates :content, presence: true
  validates :user, presence: true

  belongs_to :incident
  belongs_to :user
end
