class SearchController < ApplicationController
  def index
    @results = []
    if params[:q]
      @results = Post.search(params.to_h)
      pp params.to_h
      respond_to do |format|
        format.html { render action: "index" }
        format.json { render json: @results }
      end
    end
  end
end
