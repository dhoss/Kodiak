FactoryGirl.define do

  factory :gallery do
    name "Fartss"
    description "People farting."
    attachment { FactoryGirl.attributes_for(:attachment) }
  end
end
