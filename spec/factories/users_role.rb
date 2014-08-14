FactoryGirl.define do
  factory :users_role do
    trait :admin do
      name "admin"
    end

    trait :poster do
      name "poster"
    end

  end
end

