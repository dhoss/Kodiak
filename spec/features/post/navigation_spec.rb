require 'spec_helper'

feature 'navigate through pagination' do
  background do
    sign_up_with "fart@fart.com", "fartsens"
    user = User.find_by email: "fart@fart.com"
    1.upto(50) do |post|
      user.posts.create title: "#{post} toot", body: "huehuehuehuehue" 
    end
  end

  scenario "<nav> tag with a .pagination class" do
    visit '/'
    expect(page).to have_css 'nav.pagination'
  end

  scenario 'first page should be 1' do
    visit '/'  
    expect(find('span.page.current')).to have_content("1")
  end

  scenario "next page should have a link containing ?page=2" do
    visit '/'
    expect(page).to have_xpath('//span[@class="page"]/a[@href="/?page=2" and @rel="next"]')
  end
  
  scenario "next page should have a link containing ?page=2" do
    visit '/'
    expect(page).to have_xpath('//span[@class="next"]/a[@href="/?page=2" and @rel="next"]')
  end
  
  scenario "last page should have a link containing ?page=10" do
    visit '/'
    expect(page).to have_xpath('//span[@class="last"]/a[@href="/?page=10"]')
  end
end






