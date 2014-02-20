require 'spec_helper'

describe "posts/show" do
  include_context 'posts'

  before(:each) do
    @post = create_post
  end

  it "renders attributes in <p>" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Body/)
    rendered.should match(/Farts McGee Strikes Again/)
    rendered.should match(/Toot power/)
    rendered.should match(@post.category.name)
  end
end
