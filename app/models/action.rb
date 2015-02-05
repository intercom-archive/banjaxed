class Action < ActiveRecord::Base
  belongs_to :incident
  belongs_to :user
  serialize :data
end
