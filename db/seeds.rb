["admin", "poster"].each do |role|
  Role.create(name: role)
end
Setting.create configuration: {
  type: "site_text",
  settings:
  {
    headings: { 
      banner_title: "Kodiak",
      site_title: "Kodiak",
      tag_line: "It's a bear of a blog",
      banner_img: "kodiak.jpg" 
    },
    page_sections: { 
      about: "this is the about me section",
      other_places: [{"twitter" => "http://twitter.com/stonecolddevin"},{"github" => "http://github.com/dhoss"}]
    }
  }
}
