require 'spec_helper'

describe "posts/new" do
  before(:each) do
    assign(:post, Post.new)
  end

  it "renders new post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", posts_path, "post" do
      assert_select "input#post_title[name=?]", "post[title]"
      assert_select "input#post_body[name=?]", "post[body]"
    end
  end
end
