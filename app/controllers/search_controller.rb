class SearchController < ApplicationController
  def index
    @results = []
    if params[:q]
      @results = PgSearch.multisearch(params[:q])
      respond_to do |format|
        format.html { render action: "index" }
        format.json { render json: @results }
      end
    end
  end
end
