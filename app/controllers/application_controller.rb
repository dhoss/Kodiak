class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :archives_section, :recent_activity, :categories_section

  def archives_section
    @year_month_pairs = Post.year_month_pairs
  end

  def recent_activity
    @recent_posts  = Post.published.order(published_on: :desc).limit(5)
    @recent_photos = Attachment.where(is_public: 1).order(created_at: :desc).limit(5) 
  end

  def categories_section
    @categories_section = Category.order(created_at: :desc).all
  end
end
