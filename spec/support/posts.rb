require 'factory_girl'

shared_context 'posts' do

  def create_post
    post = FactoryGirl.create(:post)
    tag = FactoryGirl.create(:tag)
    post.tags << tag
    return post
  end

  def post_attributes
    FactoryGirl.attributes_for(:post)
  end

  def post_with_author_attributes
    post = post_attributes
    post[:user] = FactoryGirl.attributes_for(:user)
    return post
  end
end
