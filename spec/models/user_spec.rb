require 'spec_helper'

describe User do
  let(:valid_user) {{ :email => "me@fart.com", :name => "Toots McGee", :password => "T00tpower!" }}
  
  describe "User" do
    it "inserts a user" do
      expect(User.create(valid_user)).to be_valid
    end
    it "finds a user" do 
      User.create(valid_user)
      expect(User.find_by(name: "Toots McGee").name).to eq("Toots McGee")
    end
    it "updates a user" do
      user = User.create(valid_user)
      user.name = "Pffft"
      user.save
      expect(User.first.name).to eq("Pffft")
    end

    it "deletes a user" do
      user = User.create(valid_user)
      expect(User.count).to eq(1)
      user.delete
      expect(User.count).to eq(0)
    end
  end
end
