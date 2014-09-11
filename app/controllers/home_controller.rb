class HomeController < ApplicationController
  def index
    @posts = Post.front_page(params[:page])                                                                                                                                                                                   
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end
end
