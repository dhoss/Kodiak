require 'pp'
require 'actionpack/action_caching'
class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  skip_authorize_resource :only => [:index, :show] 
  before_filter :authenticate_user!, :except => [:index, :show]

  caches_action :index
  caches_action :show, expires_in: 5.minutes, layout: false


  # GET /galleries
  def index
    @galleries = Gallery.page(params[:page]).order(created_at: :desc)
    expires_in 5.minute, public: true
    fresh_when last_modified: Gallery.maximum("updated_at")
  end

  # GET /galleries/1
  def show
    expires_in 1.minute, public: true
    fresh_when last_modified: @gallery.photos.maximum("updated_at")
  end

  # GET /galleries/new
  def new
    @gallery = Gallery.new
  end

  # GET /galleries/1/edit
  def edit
  end

  # POST /galleries
  def create
    @gallery = Gallery.new(gallery_params)

    if @gallery.save
      redirect_to @gallery, notice: 'Gallery was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /galleries/1
  def update
    if @gallery.update(gallery_params)
      redirect_to @gallery, notice: 'Gallery was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /galleries/1
  def destroy
    @gallery.destroy
    redirect_to galleries_url, notice: 'Gallery was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def gallery_params
      # don't like this, but can't figure out how to get the attachment parameter to pass through
      params.require(:gallery).permit(:cover, :name, :description, :slug)
    end
end
