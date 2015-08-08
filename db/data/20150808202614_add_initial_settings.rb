class AddInitialSettings < SeedMigration::Migration
  def up
    Setting.new(configuration: 
      {
        type: "site_text",
        settings: {
          headings: {
            banner_title: "Kodiak",
            site_title: "Kodiak",
            tag_line: "Testing"
          },
          page_sections: {
            about: "this is the about me section",
            other_places: {
              github: "https://github.com/dhoss/Kodiak"
            }
          }, 
          owner_name: "Devin Austin",
          website_url: "http://192.168.1.138:8080/"
        }
     }
    ).save
  end

  def down

  end
end
