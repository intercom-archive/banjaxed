class Comment < ActiveRecord::Base
  validates :incident, presence: true
  validates :content, presence: true

  belongs_to :incident
end
