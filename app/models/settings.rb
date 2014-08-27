class Settings < ActiveRecord::Base
  store_accessor :config, :records_per_page
end
