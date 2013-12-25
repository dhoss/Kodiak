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

  let!(:user)       { FactoryGirl.create(:user) }
  let!(:post)       { FactoryGirl.create(:post, user: user) }
  let!(:valid_post) { post.to_h }

  context "with no comments" do
    it "has all required fields" do
      post.create_category(:name => "farts")
      post.tags << Tag.create(:name => "other farts")
      expect(post.comments).to     be_empty
      expect(post.category).not_to be_nil
      expect(post.tags).not_to     be_empty
      expect(post.user).to         eq(user)
    end
  end

  context "with 1 comment" do
    it "has one comment with no children" do
      comment = post.comments.create(:title => "I'm a comment", :body => "toot", :user => user)
      p "WITH COMMENTS"
      pp post.descendants
      p "COMMENT"
      pp comment
      expect(post.comments.count).to eq(1)
      post.descendants.keys.each do |child|
        expect_valid_post(
          { 
            :title => child.title,
            :body  => child.body,
            :user  => child.user
          }, 
          { 
            :title => "I'm a comment", 
            :body => "toot", 
            :user => user
          }
        )
      end
    end
  end


end
