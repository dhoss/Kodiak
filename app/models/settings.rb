class Settings < ActiveRecord::Base
  store_accessor :configuration, :posts_per_page

  def self.get(key)
    where("configuration ? :key", :key => key).first
  end
end
