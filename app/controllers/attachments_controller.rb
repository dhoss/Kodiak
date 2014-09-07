require 'pp'
class AttachmentsController < ApplicationController
  skip_authorize_resource :only => [:index, :show]
  before_filter :authenticate_user!, :except => [:index, :show]


  def index
    @attachments = Attachment.where(is_public: 1).page(params[:page])
    respond_to do |format|
      format.json { 
        render json: @attachments
      }
    end
  end

  def create
    attachment_params = {}
    attachment_params[:attachment] = params[:attachments] || params[:photo][:imagefile]
    attachment_params[:mime]       = params[:mime]        || params[:photo][:imagefile].content_type
    attachment_params[:name]       = params[:name]        || params[:photo][:imagefile].original_filename
    attachment_params[:gallery]    = Gallery.friendly.find(params[:photo][:gallery])
    @attachment = Attachment.new(attachment_params)
    respond_to do |format|
      if @attachment.save
        format.html {
          redirect_to @attachment, notice: 'Attachment successfully created'
        }
        format.json { 
          data = { id: @attachment.id, thumb: view_context.image_tag(@attachment.attachment_url(:thumb)) }
          render json: data,
                 status: :created, 
                 location: @attachment 
        }
      else
        format.json { 
          render json: @attachment.errors, 
          status: :unprocessable_entity 
        }
      end
    end
  end

  def update
    @attachment = Attachment.find(params[:id])
    attachment_attributes = params[:attachment]
    respond_to do |format|
      if @attachment.update(attachment_attributes)
        format.json { head :no_content }
        format.html { redirect_to @attachment, notice: 'Attachment was successfully updated.' }
      else 
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @attachment }
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    render :json => true
  end

  def show
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @attachment }
    end
  end
end
