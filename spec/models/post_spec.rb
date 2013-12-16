require 'spec_helper'
require'factory_girl'

describe Post do
  include_context 'test_preparation'
  include_context 'posts'
  include_context 'users'

  before(:each) do
    setup
  end

  after(:each) do
    teardown
  end

  let!(:user) { FactoryGirl.create(:user) }
  subject(:post) { FactoryGirl.create(:post, user: user, :tags_attributes => [{ :name => "farty" }]) }

  context "with no comments" do
    it "has all required fields" do
      expect(post.comments).to     be_empty
      expect(post.category).not_to be_nil
      expect(post.tags).not_to     be_empty
      expect(post.user).to         eq(user)
    end
  end


end
