require 'spec_helper'

describe "Settings" do
  describe "GET /settings" do
    it "works! (now write some real specs)" do
      @settings = FactoryGirl.create_list(:setting, 5)
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get settings_path
      response.status.should be(200)
    end
  end
end
