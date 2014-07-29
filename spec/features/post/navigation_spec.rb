require 'spec_helper'

feature 'navigate through pagination' do
  background do
    sign_up_with "fart@fart.com", "fartsens"
    user = User.find_by email: "fart@fart.com"
    1.upto(50) do |post|
      user.posts.create title: "#{post} toot", body: "huehuehuehuehue" 
    end
  end

  scenario 'first page should be 1' do
    visit '/'
    
    expect(page).to have_css 'nav.pagination'
    expect(find('span.page.current')).to have_content("1")
  end
end






