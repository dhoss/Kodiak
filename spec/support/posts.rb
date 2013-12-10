require 'factory_girl'

shared_context 'posts' do

  def create_post
    post = FactoryGirl.create(:post)
    tag = FactoryGirl.create(:tag)
    post.tags << tag
  end

  def post_attributes
    FactoryGirl.attributes_for(:post)
  end
end
