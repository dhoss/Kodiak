class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :archives_section

  def archives_section
    @year_month_pairs = Post.year_month_pairs
  end
end
