class Post < ActiveRecord::Base
  attr_accessible :body, :category, :parent, :title, :tags, :category, :user
  
  # has many
  has_many :comments, class_name: "Post", foreign_key: "parent"
  has_and_belongs_to_many :tags

  # belongs to
  belongs_to :post_comments, class_name: "Post"
  belongs_to :user
  belongs_to :category

  accepts_nested_attributes_for :tags, :category

  # maybe put me in a helper/module?
  def self.with_associations
    includes(:category, :tags, :user)
  end

  def self.has_tag?(tag)
    self.tags.include?(tag)
  end

  def self.find_with_associations(post_id)
    with_associations.find(post_id)
  end

  def self.update_post
    
  end

  def self.add_comment(comment)
    self.create(:comments =>comment)
  end
  # credit: http://justcramer.com/2010/05/30/scaling-threaded-comments-on-django-at-disqus/
  def self.list_comments
    self.find_by_sql ["WITH RECURSIVE cte (id, message, author, path, parent_id, depth)  AS (
                         SELECT  id,
                                 body,
                                 user_id,
                                 array[id] AS path,
                                 parent_id, 1 AS depth
                         FROM    posts
                         WHERE   parent_id IS NULL
                         AND     id=?

                         UNION ALL

                         SELECT  comments.id,
                                 comments.body,
                                 comments.user_id,
                                 cte.path || comments.id,
                                 comments.parent_id,
                                 cte.depth + 1 AS depth
                         FROM    posts
                         JOIN cte ON posts.parent_id = cte.id
                       )
                       SELECT id, message, author, path, depth 
                       FROM cte 
                       ORDER BY path;", self.id]
  end
end
