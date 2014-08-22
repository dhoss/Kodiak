require 'spec_helper'
require 'cancan/matchers'

describe "User" do
  include_context 'users'
  describe "abilities" do 
    let!(:user) { User.create FactoryGirl.attributes_for(:user) }
    context "with basic role" do
      it "should be able to create a post" do
        ability = Ability.new(user) 
        ability.should be_able_to(:create, Post.new)
      end
    end
    context "with admin role" do
      it "should be able to manage any post by any user"
    end
  end
end


