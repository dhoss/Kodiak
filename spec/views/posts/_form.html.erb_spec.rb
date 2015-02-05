require 'spec_helper'

describe 'posts/_form.html.erb' do
  include_context 'posts'
  include_context 'users'

  let!(:user) { User.create! user_attributes }
  let!(:user_post) { user.posts.create! post_attributes }

  context 'when we go to the new post form' do
    it 'has the correct initial publishing date value' do 
      sign_in user
      now = DateTime.new(2002,2,3).strftime("%FT%R")
      user_post.published_on = now
      assign(:post, user_post)

      render :template => 'posts/_form.html.erb'
      expect(response.body).to have_field("post[published_on]", :with => "2002-02-03T00:00:00")
    end
  end
end

