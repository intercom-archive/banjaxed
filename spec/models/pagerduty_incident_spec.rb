require 'rails_helper'

RSpec.describe PagerdutyIncident, type: :model do
  it { should validate_presence_of(:incident) }
  it { should belong_to(:incident) }
end
