FactoryGirl.define do

  factory :post do
    title "Farts McGee Strikes Again"
    body "Toot power"
    published_on DateTime.now
  end
end
