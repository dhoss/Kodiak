class Post < ActiveRecord::Base
  alias_attribute :author, :user
  include Treeify
  tree_config :cols => [:title, :user_id, :body]

  include PgSearch
  include Search
  multisearchable :against => [:title, :author, :body, :category_id, :published_on],
                  :if => lambda{ |record| record.published_on != nil }

  validates :title, presence: true
  validates :body, presence: true
 
  extend Hashifiable
  extend FriendlyId
  friendly_id :title, use: :slugged
  # has many
  has_many :comments, class_name: "Post", foreign_key: "parent_id"
  has_and_belongs_to_many :tags

  # belongs to
  belongs_to :post_comments, class_name: "Post"
  belongs_to :user
  belongs_to :category
  belongs_to :parent, class_name: "Post", touch: true

  accepts_nested_attributes_for :tags, :comments, :category

  hashify :body, :category, :parent_id, 
          :title, :tags, :category, 
          :user, :comments
  paginates_per APP_CONFIG['posts_per_page']

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


   scope :posts_by_year, ->(year) { where("extract(year from published_on) = ?", year).order(published_on: :desc) }
   scope :posts_by_month, ->(year, month) { 
     posts_by_year(year).where("extract(month from published_on) = ?", month).order(published_on: :desc) 
   }

   scope :with_author, -> { eager_load(:user) }

   scope :front_page, ->(page) { with_author.where(parent: nil).where.not(published_on: nil).order(published_on: :desc).page(page) }

   scope :drafts, -> { where(published_on: nil) }

   scope :published, -> { where.not(published_on: nil) }

   def self.distinct_years
     order('cast(extract(year from published_on) as integer) DESC').pluck('distinct(cast(extract(year from published_on) as integer))') 
   end

   def self.year_month_pairs
     select("extract(year from published_on) as year, extract(month from published_on) as month").
     order("year desc, month desc").
     group("extract(year from published_on), extract(month from published_on)")
   end

   def self.search(params)
#     order_options =  params.has_key?('order_by')     ? 
#       { params['order_by'] => params['order_type'] } : 
#       { :published_on => 'desc'}
     PgSearch.multisearch(params['q']).page(params['page']||1)
   end

   def reply_tree
     # give build_tree an array of hashes with the AR objects serialized into a hash
     build_tree(descendents.to_a.map(&:serializable_hash))
   end

   def self.delete_search_documents
     PgSearch::Document.delete_all(:searchable_type =>"Post")
   end

   def self.rebuild_pg_search_documents
     #PgSearch::Multisearch.rebuild(Post)
     find_each { |record| record.update_pg_search_document }
   end
end
