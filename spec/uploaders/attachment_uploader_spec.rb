require 'spec_helper'
require 'carrierwave/test/matchers'

describe AttachmentUploader do
  include CarrierWave::Test::Matchers
  
   
  before(:all) do
    @base_path = File.join(Rails.root, 'spec', 'data') 
    @uploader = AttachmentUploader.new(@attachment, :attachment)
    AttachmentUploader.enable_processing = true
    @uploader.store!(
      File.open(
        File.join(
          @base_path, 'jimmies.jpg'
        )
      )
    )  
  end

  after(:all) do
    AttachmentUploader.enable_processing = false
    @uploader.remove!
  end
  
  context "thumb version" do
    it "scales to be 100px wide" do
      @uploader.thumb.should be_no_larger_than(100, 100)
    end
  end
end
