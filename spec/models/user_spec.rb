require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:github_id) }
  it { should validate_uniqueness_of(:github_id) }
  it { should validate_presence_of(:github_username) }
  it { should have_many(:incidents) }
  it { should have_many(:comments) }

  describe '.create_or_update_from_github_user' do
    let(:github_user) do
      double(id: 1, login: 'some_user', name: 'some_name', gravatar_id: 'some_hash')
    end

    context "without an existing user" do
      it "creates a new user" do
        expect {
          User.create_or_update_from_github_user(github_user)
        }.to change(User, :count).by(1)
      end

      it "returns the new user" do
        new_user = User.create_or_update_from_github_user(github_user)
        expect(new_user).to eq(User.last)
      end

      it "populates the new user correctly" do
        new_user = User.create_or_update_from_github_user(github_user)
        expect(new_user.github_username).to eq(github_user.login)
        expect(new_user.name).to eq(github_user.name)
        expect(new_user.gravatar_hash).to eq(github_user.gravatar_id)
      end
    end

    context "with an existing user" do
      let!(:existing_user) { FactoryGirl.create(:user, github_id: 1) }

      it "doesn't create a new user" do
        expect {
          User.create_or_update_from_github_user(github_user)
        }.not_to change(User, :count)
      end

      it "returns the existing user" do
        user = User.create_or_update_from_github_user(github_user)
        expect(user).to eq(existing_user)
      end
    end
  end
end
