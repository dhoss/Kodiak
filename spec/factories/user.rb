require "faker"

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    password "fart1234"
    password_confirmation "fart1234"
    email { Faker::Internet.safe_email }
    association :role, factory: :users_role
  end
end
