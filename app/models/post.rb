class Post < ActiveRecord::Base
  alias_attribute :author, :user
  include Treeify

  include PgSearch
  include Search
  multisearchable :against => [:title, :author, :body, :category_id]
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


   scope :posts_by_year, ->(year) { where("extract(year from created_at) = ?", year).order(created_at: :desc) }
   scope :posts_by_month, ->(year, month) { 
     posts_by_year(year).where("extract(month from created_at) = ?", month).order(created_at: :desc) 
   }

   scope :with_author, -> { joins(:user) }

   # front_page shouldn't take a page parameter, it's one fucking page
   scope :front_page, ->(page) { with_author.where(parent: nil, is_public: 1).order(created_at: :desc).page(page) }

   scope :drafts, -> { where(is_public: 0) }

   def self.distinct_years
     order('cast(extract(year from created_at) as integer) DESC').pluck('distinct(cast(extract(year from created_at) as integer))') 
   end

   def self.year_month_pairs
     select("extract(year from created_at) as year, extract(month from created_at) as month").
     order("year desc, month desc").
     group("extract(year from created_at), extract(month from created_at)")
   end

   def self.search(params)
    results = self.fast_search(params)
    Search::Result.new(:results => results, :terms => params, :columns => [:title,:body], :to_filter => [:body]).formatted_results
   end

   def reply_tree
     # give build_tree an array of hashes with the AR objects serialized into a hash
     build_tree(descendents.to_a.map(&:serializable_hash))
   end

   def build_tree(data)
     # turn our AoH into a hash where we've mapped the ID column
     # to the rest of the hash + a comments array for nested comments
     nested_hash = Hash[data.map{|e| [e['id'], e.merge('comments' => [])]}]

     # if we have a parent ID, grab all the comments
     # associated with that parent and push them into the comments array
     nested_hash.each do |id, item|
       nested_hash[id]['name'] = item['user_id'] ? User.find(item['user_id']).name : "Anonymous"
       parent = nested_hash[item['parent_id']]
       parent['comments'] << item if parent
     end

     # return the values of our nested hash, ie our actual comment hash data
     # reject any descendents whose parent ID already exists in the main hash so we don't
     # get orphaned descendents listed as their own comment
     
     nested_hash.reject{|id, item| 
       nested_hash.has_key? item['parent_id']
     }.values
   end

end
