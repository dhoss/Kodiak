class Post < ActiveRecord::Base
  attr_accessible :author, :body, :category, :parent, :title
  
  # has many
  has_many :poststags

  # belongs to
  belongs_to :user, :foreign_key => 'id'
  belongs_to :category, :foreign_key => 'id'

end
