class Tag < ActiveRecord::Base
  attr_accessible :name

  # has_many
  has_many :posttags

  # belongs_to
end
