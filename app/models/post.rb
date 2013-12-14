class Post < ActiveRecord::Base
  attr_accessible :body, :category, :parent, :title, :tags, :category, :user
  
  # has many
  has_and_belongs_to_many :tags

  # belongs to
  belongs_to :user
  belongs_to :category

  accepts_nested_attributes_for :tags, :category

  # maybe put me in a helper/module?
  scope :with_associations, includes(:category, :tags, :user)

  def self.has_tag?(tag)
    self.tags.include?(tag)
  end

  def self.find_with_associations(post_id)
    with_associations.find(post_id)
  end

  def self.update_post
    
  end
end
