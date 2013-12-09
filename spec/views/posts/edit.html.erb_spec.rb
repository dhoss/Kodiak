require 'spec_helper'

describe "posts/edit" do
  include_context 'test_preparation'
  include_context 'posts'

  before(:each) do
    setup
    @post = create_post
  end

  after(:each) do
    teardown
  end 

  it "renders the edit post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", post_path(@post), "post" do
      assert_select "input#post_title[name=?]", "post[title]"
      assert_select "input#post_body[name=?]", "post[body]"
      assert_select "input#post_author[name=?]", "post[author]"
      assert_select "input#post_parent[name=?]", "post[parent]"
      assert_select "input#post_category[name=?]", "post[category]"
    end
  end
end
