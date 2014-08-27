require 'spec_helper'

describe Settings do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:posts) { FactoryGirl.create_list(:post, 15) }

  context "initial pagination" do
    it "returns 5 results/page" do
      expect(Post.page(1).count).to eq(5)
    end
  end
end


