require 'factory_girl'

shared_context 'users' do

  def user_attributes
    FactoryGirl.attributes_for(:user)
  end
end
