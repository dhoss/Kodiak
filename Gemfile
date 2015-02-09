if RUBY_VERSION =~ /1.9/
    Encoding.default_external = Encoding::UTF_8
    Encoding.default_internal = Encoding::UTF_8
end

source 'https://rubygems.org'

gem 'rails', '4.2.0'
gem 'kaminari', '0.16.2'
gem 'kaminari-bootstrap', '~> 3.0.1'


gem 'grape', '~> 0.10.1'
gem 'grape-rails-cache'

gem 'redis-rails'

gem "less-rails", '2.6.0' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails", '~> 3.2.0'
gem "actionpack-action_caching"
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg', '0.18.1'
gem 'devise', '~> 3.4.1'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'carrierwave', '~> 0.10.0'
gem 'fog', '1.27.0'
gem 'mini_magick', '~> 4.0.3'
gem 'friendly_id', '~> 5.1.0'
gem 'coveralls', '~> 0.7.8', require: false
gem 'faker', '~> 1.4.3'
gem 'gemnasium', '3.2.1'
gem 'unf', '~> 0.1.4'
gem 'protected_attributes', '~> 1.0.8'
gem 'hashifiable'
gem 'treeify', '0.05.02'
gem 'jquery-rails', '~> 4.0.3'
gem 'dropzonejs-rails', '~> 0.5.3'

gem 'sass-rails', '~> 5.0.1'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-ui-rails', '~> 5.0.3'
gem 'therubyracer', '~> 0.12.1', :platforms => :ruby
gem "polyamorous", :github => "activerecord-hackery/polyamorous"
gem 'pg_search', '~> 0.7.8'
gem 'closure-compiler'


# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.5'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

gem 'puma', '~> 2.11.0'

gem 'cancancan', '~> 1.10.1'

gem 'fluorescent', '0.0.6'

group :development, :test do
  gem 'capybara'
  gem 'factory_girl', '~> 4.4.0'
  gem 'rspec-rails', '~> 3.0'
  gem 'rspec-activemodel-mocks'
  gem 'syntax', '~> 1.2.0'
  gem 'rake', '~> 10.4.2'
  gem 'database_cleaner', '~> 1.4.0'
  gem 'poltergeist'
  gem "codeclimate-test-reporter", require: nil
  gem "mina"
end
