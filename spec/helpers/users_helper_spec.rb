require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#user_gravatar' do
    let(:user) { FactoryGirl.create(:user, gravatar_hash: "some_hash") }
    it "outputs the user's gravatar in the right size" do
      gravatar_html = helper.user_gravatar(user, 50)
      expect(gravatar_html).to match(%r{src="//gravatar.com/avatar/some_hash\?s=50&amp;d=mm"})
    end
  end
end
