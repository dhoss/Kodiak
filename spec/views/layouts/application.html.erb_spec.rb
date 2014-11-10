require 'spec_helper'
require 'factory_girl'

describe 'layouts/application.html.erb' do
  include_context 'posts'
  include_context 'users'

  let!(:user) { User.create! user_attributes }
  context 'when we hit a page' do
    it 'displays the correct "Archives" panel' do
      entry = user.posts.create! post_attributes 
      entry.published_on = DateTime.new(2014, 8, 8)
      entry.save
      sign_in user
      assign(:categories_section, [FactoryGirl.create(:category)])
      assign(:recent_posts, [entry])
      assign(:recent_photos, [FactoryGirl.create(:attachment)])
      assign(:year_month_pairs, Post.year_month_pairs)

      render

      expect(rendered).to have_link 'August 2014', href: '/2014/08'
    end
  end
end

