require 'factory_girl'

shared_context 'attachments' do

  def create_attachment
    attachment = FactoryGirl.create(:attachment)
    return attachment
  end

  def attachment_attributes
    FactoryGirl.attributes_for(:attachment)
  end

  def expect_valid_attachment(attachment, expected)
    attachment.should == expected
  end
end
