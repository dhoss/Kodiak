FactoryGirl.define do
  factory :attachment do
    name "jimmy rustler"
    mime "image/jpg"
    attachment { 
      Rack::Test::UploadedFile.new(
        Rails.root.join(
          *%w[spec data jimmies.jpg]
        ), 'image/jpg'
      ) 
    }
  end
end
