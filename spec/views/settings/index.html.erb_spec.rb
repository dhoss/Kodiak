require 'spec_helper'
require'factory_girl'
describe "settings/index" do
  before(:each) do
    assign(:settings, FactoryGirl.create(:setting))
  end

  it "renders a list of settings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
