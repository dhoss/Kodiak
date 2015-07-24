require 'actionpack/action_caching'
class HomeController < ApplicationController
  
  def index
    @posts = Post.front_page(params[:page])
  end
end
