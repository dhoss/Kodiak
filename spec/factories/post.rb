FactoryGirl.define do

  factory :post do
    user
    category
    title "Farts McGee Strikes Again"
    body "Toot power"

    factory :post_with_tags do 
      after_create do |post|
        create(:tag, posttags: tag)
      end
    end

  end
end
