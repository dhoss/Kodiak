["admin", "poster"].each do |role|
  Role.create(name: role)
end
config = [{
    type: "site_text",
    settings:
    {
      headings: { 
        banner_title: "Kodiak",
        site_title: "Kodiak",
        tag_line: "It's a bear of a blog",
      },
      page_sections: { 
        about: "this is the about me section",
        other_places: {"twitter" => "http://twitter.com/stonecolddevin","github" => "http://github.com/dhoss"}
      }
    }
  },
  {
    type: "site_images",
    settings: 
    {
      banner_img: "kodiak.jpg" 
    }
  }]
config.each do |c|
  Setting.create configuration: c
end

