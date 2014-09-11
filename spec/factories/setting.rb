FactoryGirl.define do
  factory :setting do
    configuration { 
      {
        type: "fart",
        settings: {
          fart: "farted"
        }  
      }
    }
  end
end

