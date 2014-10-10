require 'actionpack/action_caching'
class HomeController < ApplicationController
  
  caches_action :index


  def index
    @posts = Post.front_page(params[:page])                                                                                                                                                                                   
    expires_in 5.minute, public: true
    fresh_when last_modified: Post.maximum("updated_at")
  end
end
