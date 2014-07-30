class ArchivesController < ApplicationController
  def index 
    @posts = Post.page(params[:page]).order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def year
  end

  def month
  end

  def day
  end
end
