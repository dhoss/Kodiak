class Post < ActiveRecord::Base
  attr_accessible :author, :body, :category, :parent, :title
  
  # has many

  # belongs to
  belongs_to :user
  belongs_to :category

end
