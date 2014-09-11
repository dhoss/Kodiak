require 'spec_helper'

describe User do
  include_context 'users'
  let!(:user){ User.create! user_attributes }

  describe "Basic CRUD" do
    it "inserts a user" do
      expect(user).to be_valid
    end
    it "finds a user" do 
      expect(User.count).to eq(1)
    end
    it "updates a user" do
      user.name = "Pffft"
      user.save
      expect(User.first.name).to eq("Pffft")
    end

    it "deletes a user" do
      expect(User.count).to eq(1)
      user.delete
      expect(User.count).to eq(0)
    end
  end

  describe "Relationships" do

    it "starts with no posts" do
      expect(user.posts.count).to eq(0)
    end
    
    it "creates a post" do
      user.posts.create(title: "Fart", body: "Pffft")
      expect(user.posts.count).to eq(1)
    end
    
    it "updates a post" do
      post = user.posts.create(title: "Fart", body: "Pffft")
      post.body = "fart nugget"
      post.save
      expect(post.body).to eq("fart nugget")
    end
    
    it "deletes a post" do
      post = user.posts.create(title: "Frrrrp", body: "fart")
      expect(user.posts.count).to eq(1)
      user.posts.first.delete
      expect(user.posts.count).to eq(0)
    end
    
    it "deletes cascade when owner is deleted" do
      user.posts.create(title: "lj4law;l", body: "gkj3;ljgl3")
      expect(user.posts.count).to eq(1)
      user.delete
      expect(Post.count).to eq(0)
    end
  end

  describe "Abilities" do
    it "adds abilities properly" do
      expect(user.roles).to eq([Role.find_by(name: "poster")])
    end

    it "checks abilities properly" do
      expect(user.role? "poster").to eq(true)
    end
  end
end
