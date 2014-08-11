require 'spec_helper'

describe 'posts/_post.html.erb' do
  include_context 'posts'
  include_context 'users'

  let!(:user) { User.create! user_attributes }
  let!(:user_post) { user.posts.create! post_attributes }

  context 'when we view a post' do
    it 'has the correct user name displayed' 
  end
end

