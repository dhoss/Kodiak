if RUBY_VERSION =~ /1.9/
    Encoding.default_external = Encoding::UTF_8
    Encoding.default_internal = Encoding::UTF_8
end

source 'https://rubygems.org'

gem 'rails', '4.0.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg', '0.17.1'
gem 'devise', '~> 3.2.2'
gem 'carrierwave', '~> 0.9.0'
gem 'asset_sync', '~> 0.5.4'
gem 'fog', '~>1.19.0'
gem 'mini_magick'
gem 'friendly_id', '~> 5.0.2'
gem 'squeel', '1.1.1'
gem 'coveralls', require: false
gem 'faker'
gem 'gemnasium'
gem 'unf'
gem 'protected_attributes'
gem 'hashifiable'
gem 'acts_as_sane_tree'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'jquery-ui-rails'
  gem 'jquery-modal-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 2.4.0'
end

gem 'jquery-rails', '~> 3.0.4'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano

# To use debugger
gem 'debugger'

group :development, :test do
  gem 'factory_girl'
  gem 'rspec-rails', '~> 2.0'
  gem 'syntax'
  gem 'rake'
end

group :development do
  gem 'capistrano'
  gem 'database_cleaner'
end
