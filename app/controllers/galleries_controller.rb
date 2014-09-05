require 'pp'
class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  skip_authorize_resource :only => [:index, :show] 
  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /galleries
  def index
    @galleries = Gallery.all
  end

  # GET /galleries/1
  def show
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
    local_params = gallery_params
    local_params[:cover] = Attachment.new(attachment: gallery_params.delete(:cover))
    @gallery = Gallery.new(local_params)

    if @gallery.save
      if local_params[:cover]
        cover = @gallery.cover
        cover.gallery = @gallery
        cover.save
      end

      redirect_to @gallery, notice: 'Gallery was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /galleries/1
  def update
    # put this in a common method
    local_params = gallery_params
    if gallery_params[:cover]
      local_params[:cover] = Attachment.new(attachment: gallery_params.delete(:cover))
    end
    if @gallery.update(local_params)
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
      params.permit(:gallery,:cover, :name, :description, :slug)
    end
end
