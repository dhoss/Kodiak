class Category < ActiveRecord::Base
  attr_accessible :name, :id
  has_many :posts
  extend Hashifiable
  hashify :name, :id
end
