FactoryGirl.define do
  factory :attachment do
    name "jimmy rustler"
    mime "image/jpg"
    is_public 1
    attachment { 
      Rack::Test::UploadedFile.new(
        Rails.root.join(
          *%w[spec data jimmies.jpg]
        ), 'image/jpg'
      ) 
    }
    gallery { FactoryGirl.build(:gallery) }
  end
end
