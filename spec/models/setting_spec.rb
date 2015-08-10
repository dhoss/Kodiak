require 'spec_helper'

describe Setting do

  let!(:setting) { FactoryGirl.create(:setting) }
  context "site configuration" do
    it "starts with default config" do
      expect(Setting.get('site_text')['settings']['headings']['site_title']).to eq("Kodiak")
    end

    it "updates title" do
      pp Setting.all
      s = Setting.get('site_text')
      s['settings']['headings']['banner_title'] = "fart"
      Setting.set(s)
      expect(Setting.get('site_text')['settings']['headings']['banner_title']).to eq("fart")
    end

    it "retrieves unique settings to edit" do
      s1 = Setting.get('site_text')
      s1['settings']['headings']['banner_title'] = "pffft"
      Setting.set(s1)
      s2 = Setting.get('site_text')
      s2['settings']['headings']['banner_title'] = "pffft 2"
      Setting.set(s2)
      current_settings = Setting.distinct_settings
      expect(current_settings[0]['settings']['headings']['banner_title']).to eq("pffft 2")
    end


    it "ensures that only the latest version of a setting is shown"
  end
end


