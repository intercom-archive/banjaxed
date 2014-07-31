require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should validate_presence_of(:github_id) }
  it { should validate_uniqueness_of(:github_id) }
  it { should validate_presence_of(:github_username) }
end
