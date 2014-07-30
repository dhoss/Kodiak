require 'spec_helper'

describe ArchivesController do
  include_context 'posts'
  include_context 'users'

  let!(:user) { User.create! user_attributes }
  let!(:user_post) { user.posts.create! post_attributes }

  describe "GET index" do
    it "lists all posts sorted by year" do
      get :index
      assigns(:posts).should eq([user_post])
    end
  end

  describe "GET year" do
    it "lists posts by a specified year"
  end

  describe "GET month" do
    it "lists posts by a specified month"
  end

  describe "GET day" do
    it "lists post by a specified day"
  end

end
