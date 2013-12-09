require 'factory_girl'

shared_context 'posts' do

  def create_post
    FactoryGirl.create(:post)
  end

  def post_attributes
    FactoryGirl.attributes_for(:post)
  end
end
