class Tag < ActiveRecord::Base
  attr_accessible :name

  # has_many
  has_and_belongs_to_many :posts

  # belongs_to
end
