require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  before(:each) do
    request.env['warden'] = double(user: github_user)
  end

  describe "#current_user" do
    context "when a user is signed in" do
      let(:user) { FactoryGirl.create(:user) }
      let(:github_user) { double(id: user.github_id) }

      it "returns the signed in user" do
        expect(controller.current_user).to eq(user)
      end
    end

    context "when no user is signed in" do
      let(:github_user) { nil }

      it "returns nil" do
        expect(controller.current_user).to be_nil
      end
    end
  end

  describe "#user_signed_in?" do
    describe "when a user is signed in" do
      let(:github_user) { double(id: 1) }

      it "returns true" do
        expect(controller.user_signed_in?).to be(true)
      end
    end

    describe "when no user is signed in" do
      let(:github_user) { nil }

      it "returns false" do
        expect(controller.user_signed_in?).to be(false)
      end
    end
  end

end
