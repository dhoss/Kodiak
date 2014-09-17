class PhotosController < ApplicationController
  skip_authorize_resource :only => [:index, :show] 
  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /photos
  def index
    @photos = Attachment.photos
    respond_to do |format|
      format.html
      format.json { render json: @photos }
    end
  end

  # GET /photos/1
  def show
    @photo = Attachment.find_by(id: params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  def new
    @photo = Attachment.new
    @gallery = params[:id]
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  def create
    @photo = Attachment.new(photo_params)

    if @photo.save
      redirect_to @photo, notice: 'Photo was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /photos/1
  def update
    if @photo.update(photo_params)
      redirect_to @photo, notice: 'Photo was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /photos/1
  def destroy
    @photo.destroy
    redirect_to photos_url, notice: 'Photo was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Attachment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def photo_params
      params(:photo, :attachment['gallery'])
    end
end
