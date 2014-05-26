if RUBY_VERSION =~ /1.9/
    Encoding.default_external = Encoding::UTF_8
    Encoding.default_internal = Encoding::UTF_8
end

source 'https://rubygems.org'

gem 'rails', '4.0.3'
gem 'kaminari', '0.15.1'
gem 'simple-navigation'
gem 'simple-navigation-bootstrap'

gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg', '0.17.1'
gem 'devise', '~> 3.2.3'
gem 'carrierwave', '~> 0.9.0'
gem 'asset_sync', '~> 1.0.0'
gem 'fog', '~>1.20.0'
gem 'mini_magick'
gem 'friendly_id', '~> 5.0.3'
gem 'squeel', '1.1.1'
gem 'coveralls', require: false
gem 'faker'
gem 'gemnasium', '3.0.1'
gem 'unf'
gem 'protected_attributes'
gem 'hashifiable'
gem 'acts_as_sane_tree'
gem 'jquery-rails', '~> 3.1.0'
gem 'dropzonejs-rails'

gem 'sass-rails'
gem 'coffee-rails'
gem 'jquery-ui-rails', '~> 4.2.0'
gem 'jquery-fileupload-rails'
gem 'jquery-modal-rails'
gem 'therubyracer', '~> 0.12.1', :platforms => :ruby
gem 'uglifier', '>= 2.4.0'
gem "polyamorous", :github => "activerecord-hackery/polyamorous"
gem 'pg_search'


# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

gem 'puma'

group :development do 
  # To use debugger
  gem 'debugger'
end 

group :development, :test do
  gem 'capybara'
  gem 'factory_girl', '~> 4.4.0'
  gem 'rspec-rails', '~> 2.14.1'
  gem 'syntax', '~> 1.2.0'
  gem 'rake'
  gem 'capistrano', '~> 3.1.0'
  gem 'database_cleaner'
  gem 'poltergeist'
end
