class Setting < ActiveRecord::Base
  store_accessor :configuration, :posts_per_page

  def self.get(key)
    where("configuration ->> 'type' = ?", key).order(id: :desc).first.configuration
  end

  # now we have versioned configuration
  def self.set(hash)
    create(configuration: hash)
  end

  def self.distinct_settings
    select("DISTINCT ON(settings.id) settings.*")
  end
end
