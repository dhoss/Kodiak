require 'spec_helper'

describe User do
  before :each do
    @valid_user = { :email => "me@fart.com", :name => "Toots McGee", :password => "T00tpower!", :roles => [Role.find_or_create_by(name: "poster")] }
    @user =  User.create(@valid_user) 
  end

  describe "Basic CRUD" do
    it "inserts a user" do
      expect(@user).to be_valid
    end
    it "finds a user" do 
      expect(User.find_by(name: "Toots McGee").name).to eq("Toots McGee")
    end
    it "updates a user" do
      @user.name = "Pffft"
      @user.save
      expect(User.first.name).to eq("Pffft")
    end

    it "deletes a user" do
      expect(User.count).to eq(1)
      @user.delete
      expect(User.count).to eq(0)
    end
  end

  describe "Relationships" do

    it "starts with no posts" do
      expect(@user.posts.count).to eq(0)
    end
    
    it "creates a post" do
      @user.posts.create(title: "Fart", body: "Pffft")
      expect(@user.posts.count).to eq(1)
    end
    
    it "updates a post" do
      post = @user.posts.create(title: "Fart", body: "Pffft")
      post.body = "fart nugget"
      post.save
      expect(post.body).to eq("fart nugget")
    end
    
    it "deletes a post" do
      post = @user.posts.create(title: "Frrrrp", body: "fart")
      expect(@user.posts.count).to eq(1)
      @user.posts.first.delete
      expect(@user.posts.count).to eq(0)
    end
    
    it "deletes cascade when owner is deleted" do
      @user.posts.create(title: "lj4law;l", body: "gkj3;ljgl3")
      expect(@user.posts.count).to eq(1)
      @user.delete
      expect(Post.count).to eq(0)
    end
  end

  describe "User Roles" do
    it "starts with the 1 role" do
      expect(@user.roles.count).to eq (1)
    end

    it "starts with the 'poster' role" do
      expect(@user.role?("poster")).to eq(true)
    end

    it "has the 'admin' role added" do
      @user.add_role("admin")
      expect(@user.role?("admin")).to eq (true)
    end
  end
end
