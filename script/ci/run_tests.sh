export LANG=en_US.UTF-8; 
export LC_ALL=en_US.UTF-8;
export CODECLIMATE_REPO_TOKEN=3d255b2cfd37d4db29b81c8ec30c17bac274d5b062024b8254cba978134309ee 
RAILS_ENV=test bundle exec rake seed_migration:install:migrations
RAILS_ENV=test bundle exec rake db:migrate
RAILS_ENV=test bundle exec rake seed:migrate
RAILS_ENV=test bundle exec rspec
