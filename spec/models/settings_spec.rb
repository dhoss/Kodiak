require 'spec_helper'

describe Settings do
  let!(:posts) { FactoryGirl.create_list(:post, 15) }

  context "posts_per_page configuration" do
    it "starts with default config" do
      expect(Settings.get('banner_title')).to eq("Kodiak")
    end

    it "updates title" do
      Settings.set("banner_title", "fart")
      expect(Settings.get("banner_title")).to eq("fart")
    end
  end
end


