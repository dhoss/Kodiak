require 'spec_helper'

describe ArchivesController do
  include_context 'posts'
  include_context 'users'

  let!(:user) { User.create! user_attributes }
  let!(:post_2014) { user.posts.create! post_attributes }
  let!(:post_2013) { user.posts.create! post_attributes }
  before(:each) do
    post_2014.created_at = DateTime.new(2014, 7, 31)
    post_2014.save

    post_2013.created_at = DateTime.new(2013, 8, 1)
    post_2013.save
  end

  describe "GET index" do
    it "lists all posts sorted by year" do
      get :index
      assigns(:posts).map {|d| d.created_at.year }.should eq [2014, 2013]
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
