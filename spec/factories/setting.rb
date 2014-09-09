FactoryGirl.define do
  factory :setting do
    configuration { 
      {
        banner_title: "Kodiak", 
        site_title: "Kodiak",
        tag_line: "It's a bear of a blog",
        banner_img: "kodiak.jpg",
        about_section: "this is the about me section",
        other_places: [{"twitter" => "http://twitter.com/stonecolddevin"},{"github" => "http://github.com/dhoss"}]
      }
    }
  end
end

