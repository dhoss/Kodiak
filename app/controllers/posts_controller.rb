require 'pp'
require 'actionpack/action_caching'
class PostsController < ApplicationController
  skip_authorize_resource :only => [:index, :show] 
  before_filter :authenticate_user!, :except => [:index, :show]

  caches_action :index, :layout => false

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.front_page(params[:page])
    expires_in 1.minute, public: true
    fresh_when last_modified: Post.maximum("updated_at")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.includes(:user, :parent).friendly.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @user = current_user
    @post = Post.new
    @post.user(@user)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.friendly.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @user = current_user
    @new_category = params[:post].delete "new_category"
    @post = @user.posts.new(params[:post])
    if !@new_category.blank?
      @post.category = Category.new(name: @new_category)
    end

    respond_to do |format|
      if @post.save
        expire_action :action => :index
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.friendly.find(params[:id])
    post_params = params[:post]
    if !post_params[:new_category].blank?
      post_params[:category] = Category.new(name: post_params.delete(:new_category))
    else
      post_params.delete(:new_category)
    end
    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.friendly.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def reply
    @post = Post.includes(:parent).friendly.find(params[:id])
    @post.comments.create(
      user: user_signed_in? ? current_user : User.find_or_initialize(name: params[:commentor_name]),
      title: "RE: #{@post.title}", 
      body: params[:post][:body],
      category: @post.category

    )

    respond_to do |format|
      format.html { redirect_to post_url(@post) }
      format.json { head :no_content }
    end
  end

  def new_reply
    @post = Post.friendly.find(params[:id])
  end
end
