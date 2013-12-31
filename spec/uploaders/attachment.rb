require 'carrierwave/test/matchers'

describe Attachment do
  include CarrierWave::Test::Matchers
  
  let(:base_path) { File.join(Rails.root, 'spec', 'data') }
  let(:uploader)  { Attachment.new(@post, :attachment) }
  p base_path 
  before(:all) do
    p base_path
    Attachment.enable_processing = true
    #uploader.store!(
    #  File.open(
    #    File.join(
    #      base_path, 'jimmies-stable.png'
    #    )
    #  )
    #)  
  end

  after(:all) do
    Attachment.enable_processing = false
    uploader.remove!
  end
  
  context "thumb version" do
    it "scales to be 100px wide" do
      uploader.thumbnail.should be_no_larger_than(100, 100)
    end
  end
end
