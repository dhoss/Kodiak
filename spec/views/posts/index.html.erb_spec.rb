require 'spec_helper'

describe "posts/index" do
  include_context 'test_preparation'
  include_context 'posts'

  before(:each) do
    setup
    assign(:posts, [create_post, create_post])
  end

  after(:each) do
    teardown
  end 

  it "renders a list of posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Farts McGee Strikes Again".to_s, :count => 2
    assert_select "tr>td", :text => "Toot power".to_s, :count => 2
    assert_select "tr>td", :text => "Farts McGee Strikes Again", :count => 2
    assert_select "tr>td", :text => "Farts McGee Strikes Again".to_s, :count => 2
    assert_select "tr>td", :text => "Farts McGee Strikes Again".to_s, :count => 2
  end
end
