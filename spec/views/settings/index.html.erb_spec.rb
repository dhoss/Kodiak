require 'spec_helper'
require'factory_girl'
describe "settings/index" do
  let!(:settings){ FactoryGirl.create_list(:setting, 5) }

  it "renders a list of settings" do
    @settings = settings
    render
  end
end
