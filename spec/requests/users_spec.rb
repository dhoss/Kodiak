require 'spec_helper'
require 'pp'
describe "Users" do
  describe "Twitter auth" do
    it "allows a user to authenticate via twitter" do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        :provider => 'twitter',
        :uid => '123545'
      })
      get user_omniauth_authorize_path(:twitter)
      response.status.should be(302)
      pp response
      pp User.last
      User.last.uid.should eq(123545)
    end
  end
end
