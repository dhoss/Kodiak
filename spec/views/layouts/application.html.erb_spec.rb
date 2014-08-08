require 'spec_helper'

describe 'layouts/application.html.erb' do
  include_context 'posts'
  include_context 'users'

  let!(:user) { User.create! user_attributes }
  let!(:user_post) { 
    user.posts.create! post_attributes, created_at: DateTime.new(2014, 8, 8) 
  }

  context 'when we hit a page' do
    it 'displays the correct "Archives" panel' do
      sign_in user
      pp user_post
      assign(:year_month_pairs, Post.year_month_pairs)

      render

      expect(rendered).to have_link 'August 2014', href: '/2014/08'
    end
  end
end

