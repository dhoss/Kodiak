echo `ls -la`
psql -U postgres kodiak_test < sql/install_trigram_and_fuzzy_search_extensions.sql;
export LANG=en_US.UTF-8; 
export LC_ALL=en_US.UTF-8;
RAILS_ENV=test bundle exec rake db:migrate
RAILS_ENV=test bundle exec rspec
