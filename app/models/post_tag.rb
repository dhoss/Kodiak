class PostTag < ActiveRecord::Base
  attr_accessible :post_id, :tag_id
  
  # has_many
  
  # belongs_to
  belongs_to :posts
  belongs_to :tags
end
