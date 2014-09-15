class Setting < ActiveRecord::Base
  store_accessor :configuration, :posts_per_page

  def self.get(key)
    where("configuration ->> 'type' = ?", key).order(id: :desc).first.configuration
  end

  # now we have versioned configuration
  def self.set(hash)
    create(configuration: hash)
  end

  def self.distinct_settings(page=nil)
    page ||= 1
    settings = []
    select("DISTINCT ON(settings.id) settings.*")
      .page(page)
      .order(id: :desc)
      .map{|setting| settings << {:id => setting.id}.merge(setting.configuration)}
    settings.uniq!{|s| s['type']}
  end
end
