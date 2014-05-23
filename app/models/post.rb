class Post < ActiveRecord::Base
  acts_as_sane_tree
  attr_accessible :body, 
                  :category, 
                  :parent, 
                  :title, 
                  :tags, 
                  :category_id, 
                  :user,
                  :attachments_attributes,
                  :attachments

  include PgSearch
  include Search
  multisearchable :against => [:title, :author, :body, :category_id]
  validates :title, presence: true
  validates :body, presence: true
 
  extend Hashifiable
  # has many
  has_many :comments, class_name: "Post", foreign_key: "parent_id"
  has_many :attachments, :as => :attachable
  has_and_belongs_to_many :tags

  # belongs to
  belongs_to :post_comments, class_name: "Post"
  belongs_to :user
  belongs_to :category

  accepts_nested_attributes_for :tags, :comments, :category, :attachments

  hashify :body, :category, :parent_id, 
          :title, :tags, :category, 
          :user, :comments, :children

  paginates_per 25

  def has_tag?(tag)
    self.tags.include?(tag)
  end

  pg_search_scope :fast_search,
                  :against => [:title, :body],
                  :using   => {
                    tsearch: {
                      dictionary: 'english',
                      tsvector_column: 'tsv'
                    },
                    trigram: {}
                  }

   def self.search(params)
    results = self.fast_search(params)
    Search::Result.new(:results => results, :terms => params, :columns => [:title,:body], :to_filter => [:body]).formatted_results
   end

end
