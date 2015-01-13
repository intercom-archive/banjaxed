class Incident < ActiveRecord::Base
  SEVERITY_VALUES = %w(critical high medium low).freeze
  STATUS_VALUES = %w(open mitigated resolved closed).freeze

  validates :title, presence: true
  validates :description, presence: true
  validates :severity, inclusion: { in: SEVERITY_VALUES }
  validates :status, inclusion: { in: STATUS_VALUES }
  validates :user, presence: true

  has_many :comments
  has_one  :pagerduty_incident
  belongs_to :user
end
