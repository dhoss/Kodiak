require 'spec_helper'

feature 'user creates a post' do
  scenario 'user signs up and creates a post', :js => true do
    sign_up_with "fart@fart.com", "fartsens"

    expect(page).to have_content('Kodiak')

    visit new_post_path
    print page.html
    fill_in 'post[title]', with: "farts"
    fill_in 'post[body]',  with: "fart fart fart"
    find('a#new-category').trigger('click')
    fill_in 'category[name]', with: "pffbbhhhhttttbbbt"
    click_button "Create Category"
    find('#post-submit-btn').trigger('click')

    expect(page).to have_content("Post was successfully created.")
  end
end

