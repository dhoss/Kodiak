["admin", "poster"].each do |role|
  Role.create(name: role)
end
Settings.create configuration: {
  banner_title: "Kodiak"
}
