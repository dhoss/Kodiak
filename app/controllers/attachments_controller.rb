class AttachmentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]


  def index
    @attachments = Attachments.where(:public => 1)
    respond_to do |format|
      format.json { 
        render json: @attachments.connect{|a| a.to_jq_upload }.to_json 
      }
    end
  end

  def create
    @attachment = Attachment.new(:attachment => params[:attachments])
    respond_to do |format|
      if @attachment.save
        format.json { 
          render json: [@attachment.to_jq_upload].to_json,
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
  end

  def edit
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    render :json => true
  end

  def show
    @attachment = Attachment.where(id: params[:id]).first

    respond_to do |format|
      format.html
      format.json { render json: @attachment }
    end
  end
end
