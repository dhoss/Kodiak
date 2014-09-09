bundle exec rake db:create RAILS_ENV=test_local &&
bundle exec rake db:create RAILS_ENV=development &&
psql -Upostgres < db/create_kodiak_users.sql &&
psql -Upostgres kodiak_test < db/search_extensions.sql &&
psql -Upostgres kodiak_dev < db/search_extensions.sql &&
bundle exec rake db:migrate RAILS_ENV=test_local && 
bundle exec rake db:migrate RAILS_ENV=development && 
bundle exec rake db:seed RAILS_ENV=test_local &&
bundle exec rake db:seed RAILS_ENV=development
