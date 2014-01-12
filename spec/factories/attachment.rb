factory :attachment do
  file { 
    fixture_file_upload(
      Rails.root.join(
        *%w[spec fixtures files jimmies-stable.jpg]
      ), 'image/jpg'
    ) 
  }
end
