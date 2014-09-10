require 'spec_helper'

describe "settings/show" do
  let!(:setting){ FactoryGirl.create(:setting) }

  it "renders attributes" do
    @setting = setting
    render
  end
end
