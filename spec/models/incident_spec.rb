require 'rails_helper'

RSpec.describe Incident, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should ensure_inclusion_of(:severity).in_array(%w(critical high medium low)) }
  it { should ensure_inclusion_of(:status).in_array(%w(open mitigated resolved closed)) }
  it { should have_many(:comments) }
end
