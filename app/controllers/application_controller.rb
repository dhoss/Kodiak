class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :archives_section, :recent_activity

  def archives_section
    @year_month_pairs = Post.year_month_pairs
  end

  def recent_activity
    @recent_posts  = Post.where(is_public: 1).order(created_at: :desc).limit(5)
    @recent_photos = Attachment.where(is_public: 1).order(created_at: :desc).limit(5) 
  end
end
