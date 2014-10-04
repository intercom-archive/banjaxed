require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#user_avatar' do
    let(:user) { FactoryGirl.create(:user, avatar_url: "//some_url") }
    it "outputs the user's avatar in the right size" do
      avatar_html = helper.user_avatar(user, 50)
      expect(avatar_html).to match(%r{src="//some_url"})
      expect(avatar_html).to match(%r{width="50"})
      expect(avatar_html).to match(%r{height="50"})
    end
  end
end
