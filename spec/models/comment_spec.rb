require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it { should validate_presence_of(:incident) }
  it { should validate_presence_of(:content) }
  it { should belong_to(:incident) }
  it { should belong_to(:user) }
end
