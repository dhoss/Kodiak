require "faker"
FactoryGirl.define do

  factory :gallery do
    name { Faker::Name.name }
    description "People farting."
  end
end
