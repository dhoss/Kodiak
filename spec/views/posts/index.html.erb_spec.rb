require 'spec_helper'

describe "posts/index" do
  it "renders a list of posts" do
  pending "View tests suck.  Pending until I use capybara"
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Farts McGee Strikes Again", :count => 2
    assert_select "tr>td", :text => "Toot power",                :count => 2
    assert_select "tr>td", :text => "Farts McGee Strikes Again", :count => 2
    assert_select "tr>td", :text => "Farts McGee Strikes Again", :count => 2
    assert_select "tr>td", :text => "Farts McGee Strikes Again", :count => 2
  end
end
