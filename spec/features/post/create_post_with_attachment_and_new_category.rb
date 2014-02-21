require 'spec_helper'

feature 'user creates a post' do
  scenario 'with a new category' do
    sign_up_with "fart@fart.com", "fartsens"

    expect(page).to have_content('Kodiak')
  end
end

