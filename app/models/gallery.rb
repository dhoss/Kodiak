class Gallery < ActiveRecord::Base
  paginates_per APP_CONFIG['posts_per_page']
  extend FriendlyId
  friendly_id :name, use: :slugged
end
