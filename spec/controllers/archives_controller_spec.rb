require 'spec_helper'

describe ArchivesController, :type => :controller do
  include_context 'posts'
  include_context 'users'

  let!(:user) { User.create! user_attributes }
  let!(:post_2014) { user.posts.create! post_attributes }
  let!(:post_2013) { user.posts.create! post_attributes }
  before(:each) do
    post_2014.published_on = DateTime.new(2014, 7, 31)
    post_2014.save

    post_2013.published_on = DateTime.new(2013, 8, 1)
    post_2013.save
  end

  describe "GET index" do
    it "lists all posts sorted by year" do
      get :index
      expect(assigns(:years)).to eq [2014, 2013]
    end
  end

  describe "GET year" do
    it "lists posts by a specified year" do
      get :year, { :year => 2014 }
      expect(assigns(:posts)).to eq([post_2014])
    end
  end

  describe "GET month" do
    it "lists posts by a specified month" do
      get :month, { :year => 2014, :month => 07 }
      expect(assigns(:posts)).to eq([post_2014])
    end
  end

  describe "GET day" do
    it "lists post by a specified day"
  end

end
