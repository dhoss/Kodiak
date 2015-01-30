# encoding: utf-8 
require 'spec_helper'



feature 'twitter auth' do
  before :all do
    
  end
  scenario "signing in with twitter" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:twitter, {:uid => '12345'})
    visit user_omniauth_authorize_path(:twitter)
    User.last.uid.should eq('12345')
  end
end 
