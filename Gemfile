if RUBY_VERSION =~ /1.9/
    Encoding.default_external = Encoding::UTF_8
    Encoding.default_internal = Encoding::UTF_8
end

source 'https://rubygems.org'

gem 'rails', '4.1.2.rc3'
gem 'kaminari', '0.15.1'
gem 'simple-navigation'
gem 'simple-navigation-bootstrap'
gem 'foreman-export-initscript'

gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails", '~> 2.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg', '0.17.1'
gem 'devise', '~> 3.2.4'
gem 'carrierwave', '~> 0.10.0'
#gem 'asset_sync', '~> 1.0.0'
gem 'fog', '1.22.0'
gem 'mini_magick'
gem 'friendly_id', '~> 5.0.3'
gem 'coveralls', require: false
gem 'faker', '~> 1.3.0'
gem 'gemnasium', '3.0.1'
gem 'unf', '~> 0.1.4'
gem 'protected_attributes', '~> 1.0.7'
gem 'hashifiable'
gem 'treeify'
gem 'jquery-rails', '~> 3.1.0'
gem 'dropzonejs-rails', '~> 0.4.14'

gem 'sass-rails', '~> 4.0.3'
gem 'coffee-rails'
gem 'jquery-ui-rails', '~> 4.2.1'
gem 'therubyracer', '~> 0.12.1', :platforms => :ruby
gem "polyamorous", :github => "activerecord-hackery/polyamorous"
gem 'pg_search', '~> 0.7.4'
gem 'foreigner'
gem 'closure-compiler'


# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.5'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

gem 'puma', '~> 2.8.2'

gem 'cancancan', '~> 1.9.2'

group :development, :test do
  gem 'capybara'
  gem 'factory_girl', '~> 4.4.0'
  gem 'rspec-rails', '~> 2.14.2'
  gem 'syntax', '~> 1.2.0'
  gem 'rake', '~> 10.3.2'
  gem 'database_cleaner', '~> 1.3.0'
  gem 'poltergeist'
  gem "codeclimate-test-reporter", require: nil
  gem "mina"
end
