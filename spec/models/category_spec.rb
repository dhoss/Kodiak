require 'spec_helper'

describe Category do
  subject { Category.new(:name => "pfff") }
  it "creates a valid Category object" do
    subject.should be_valid
  end
  it "is invalid without a name" do 
    c = Category.new(:name => nil)
    c.should_not be_valid
    c.errors.messages[:name].should include "can't be blank"

  end
  it "is invalid if it's a duplicate" do
    c  = Category.create(:name => 'pfff')
    c2 = Category.new(:name => 'pfff')
    c2.should_not be_valid
    c2.errors.messages[:name].should include "has already been taken"
  end
end
