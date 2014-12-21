class PagerdutyIncident < ActiveRecord::Base
  validates :incident, presence: true
  belongs_to :incident
end
