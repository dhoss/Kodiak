class Attachment < ActiveRecord::Base
  attr_accessible :name, :path, :mime
  belongs_to :post_id
end
