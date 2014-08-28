require 'spec_helper'

describe Settings do
  let!(:posts) { FactoryGirl.create_list(:post, 15) }

  context "posts_per_page configuration" do
    it "starts with no configuration" do
      expect(Settings.get('posts_per_page')).to eq(nil)
    end

    it "sets pagination configuration" do
      s = Settings.create configuration: {posts_per_page: 10}
      expect(s.posts_per_page.to_i).to eq(10)
    end
  end
end


