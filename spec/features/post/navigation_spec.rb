# encoding: utf-8 
require 'spec_helper'

feature 'navigate through pagination' do
  before :each do
    
  end

  scenario "<nav> tag with a .pagination class" do
    sign_up_with "fart@fart.com", "fartsens"
    user = User.find_by email: "fart@fart.com"
    1.upto(50) do |post|
      user.posts.create title: "#{post} toot", body: "huehuehuehuehue" 
    end
    visit '/'
    expect(page).to have_css 'nav.pagination'
  end

  scenario 'first page should be 1' do
    sign_up_with "fart@fart.com", "fartsens"
    user = User.find_by email: "fart@fart.com"
    1.upto(50) do |post|
      user.posts.create title: "#{post} toot", body: "huehuehuehuehue" 
    end
    visit '/'  
    expect(find('span.page.current')).to have_content("1")
  end

  scenario "next page should have a link containing ?page=2" do
    sign_up_with "fart@fart.com", "fartsens"
    user = User.find_by email: "fart@fart.com"
    1.upto(50) do |post|
      user.posts.create title: "#{post} toot", body: "huehuehuehuehue" 
    end
    visit '/'
    expect(page).to have_xpath('//span[@class="page"]/a[@href="/?page=2" and @rel="next"]')
  end
  
  scenario "next page should have a link containing ?page=2" do
    sign_up_with "fart@fart.com", "fartsens"
    user = User.find_by email: "fart@fart.com"
    1.upto(50) do |post|
      user.posts.create title: "#{post} toot", body: "huehuehuehuehue" 
    end
    visit '/'
    expect(page).to have_xpath('//span[@class="next"]/a[@href="/?page=2" and @rel="next"]')
  end
  
  scenario "last page should have a link containing ?page=10" do
    sign_up_with "fart@fart.com", "fartsens"
    user = User.find_by email: "fart@fart.com"
    1.upto(50) do |post|
      user.posts.create title: "#{post} toot", body: "huehuehuehuehue" 
    end
    visit '/'
    expect(page).to have_xpath('//span[@class="last"]/a[@href="/?page=10"]')
  end

  scenario "clicking the page 2 link takes us to ?page=2" do
    sign_up_with "fart@fart.com", "fartsens"
    user = User.find_by email: "fart@fart.com"
    1.upto(50) do |post|
      user.posts.create title: "#{post} toot", body: "huehuehuehuehue" 
    end
    visit "/"
    click_link "2"
    expect(find('span.page.current')).to have_content("2")
  end

  scenario "from page 2, next page should be ?page=3" do
    sign_up_with "fart@fart.com", "fartsens"
    user = User.find_by email: "fart@fart.com"
    1.upto(50) do |post|
      user.posts.create title: "#{post} toot", body: "huehuehuehuehue" 
    end
    visit "/?page=2"
    expect(page).to have_xpath('//span[@class="next"]/a[@href="/?page=3" and @rel="next"]')
  end

  scenario "next page should take us to ?page=2" do
    sign_up_with "fart@fart.com", "fartsens"
    user = User.find_by email: "fart@fart.com"
    1.upto(50) do |post|
      user.posts.create title: "#{post} toot", body: "huehuehuehuehue" 
    end
    visit "/"
    click_link 'Next ›'

    expect(find('span.page.current')).to have_content("2")
  end

  scenario "last page should take us to ?page=10" do
    sign_up_with "fart@fart.com", "fartsens"
    user = User.find_by email: "fart@fart.com"
    1.upto(50) do |post|
      user.posts.create title: "#{post} toot", body: "huehuehuehuehue" 
    end
    visit "/"
    click_link 'Last »'

    # turn me into a helper
    expect(find('span.page.current')).to have_content("10")
  end
end






