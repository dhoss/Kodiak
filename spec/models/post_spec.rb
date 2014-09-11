require 'spec_helper'
require'factory_girl'

describe Post do
  include_context 'posts'
  include_context 'users'

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
      expect(post.comments.count).to eq(1)
      post.descendents.each do |child|
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

  context "with sub-comments" do 
    it "has one comment with several children" do
      # turn me into a method to be re-usable
      comment         = post.comments.create(
        :title => "I'm a comment", 
        :body => "toot"
      )
      sub_comment     = comment.comments.create(
        :title => "I'm a comment of '#{comment.title}'", 
        :body => "toot 2"
      )
      sub_sub_comment = sub_comment.comments.create(
        :title => "I'm a comment of '#{sub_comment.title}'", 
        :body => "toot 3"
      )
      expect(post.comments.count).to eq(1)
      expect(comment.comments.count).to eq(1)
      expect(post.descendents.count).to eq(3) 
    end
  end

  context "search posts" do
    it "returns search results" do
      results = Post.fast_search(post.title)
      expect(results).not_to be_empty
    end
  end
end
