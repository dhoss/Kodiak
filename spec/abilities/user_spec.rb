require 'cancan/matchers'

describe "User" do
  describe "abilities" do 
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }

    context "with basic role" do
      it "should be able to create a post"
    end
  end
end


