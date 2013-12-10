FactoryGirl.define do

  factory :post do
    user
    category
    title "Farts McGee Strikes Again"
    body "Toot power"

    factory :post_with_tags do 
      after_create do |post|
        FactoryGirl.create_list(:tag, tags: [post])
      end
    end

  end
end
