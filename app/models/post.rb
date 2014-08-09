class Post < ActiveRecord::Base

  alias_attribute :author, :user
  include Treeify

  include PgSearch
  include Search
  multisearchable :against => [:title, :author, :body, :category_id]
  validates :title, presence: true
  validates :body, presence: true
 
  extend Hashifiable
  # has many
  has_many :comments, class_name: "Post", foreign_key: "parent_id"
  has_many :attachments, as: :attachable
  has_and_belongs_to_many :tags

  # belongs to
  belongs_to :post_comments, class_name: "Post"
  belongs_to :user
  belongs_to :category
  belongs_to :parent

  accepts_nested_attributes_for :tags, :comments, :category, :attachments

  hashify :body, :category, :parent_id, 
          :title, :tags, :category, 
          :user, :comments

  paginates_per 5

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

   scope :front_page, ->(page) { order(created_at: :desc).page(page) }

   scope :posts_by_year, ->(year) { where("extract(year from created_at) = ?", year) }
   scope :posts_by_month, ->(year, month) { posts_by_year(year).where("extract(month from created_at) = ?", month) }

   def self.distinct_years
     pluck('distinct(extract(year from created_at))').map {|year| year.to_i} 
   end

   def self.year_month_pairs
     select("extract(year from created_at) as year, extract(month from created_at) as month").
     group("extract(year from created_at), extract(month from created_at)")
   end


   def self.search(params)
    results = self.fast_search(params)
    Search::Result.new(:results => results, :terms => params, :columns => [:title,:body], :to_filter => [:body]).formatted_results
   end

end
