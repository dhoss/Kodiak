["admin", "poster"].each do |role_name|
  Role.create(name: role_name)
end
