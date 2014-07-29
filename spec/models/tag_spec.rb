require 'spec_helper'
require 'factory_girl'

describe Tag do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.create(:post, user: user) }
  describe "Basic CRUD" do
    it "can add tags to an existing post." do
      post.tags << Tag.create(name: "pffft")
      expect(post.tags.count).to eq(1)
    end
  end

end
