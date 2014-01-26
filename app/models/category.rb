class Category < ActiveRecord::Base
  attr_accessible :name, :category_id
  has_many :posts
end
