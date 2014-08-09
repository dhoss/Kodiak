require 'pp'
class ArchivesController < ApplicationController
  def index 
    @years = Post.distinct_years

    respond_to do |format|
      format.html
      format.json { render json: @years }
    end
  end

  def year
    @year  = params[:year]
    @posts = Post.posts_by_year(@year).page(params[:page])
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def month
    @year  = params[:year]
    @month = params[:month]
    @posts = Post.posts_by_month(@year, @month).page(params[:page])
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def day
  end
end
