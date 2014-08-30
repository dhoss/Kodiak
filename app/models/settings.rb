class Settings < ActiveRecord::Base
  store_accessor :configuration, :posts_per_page

  def self.get(key)
    c = where("configuration ? :key", :key => key).pluck(:configuration)[0]

    if c.is_a?(Hash) 
      if c.has_key? key
        return c[key].match(/^\d+$/) ? c[key].to_i : c[key]
      end
    end

    return nil
  end

  def self.set(key, value)
    config = where("configuration ? :key", :key =>  key)
    config = config.first
    config.configuration = {key => value}
    config.save
  end
end
