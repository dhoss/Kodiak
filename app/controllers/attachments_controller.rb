class AttachmentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]


  def index
    @attachments = Attachment.where(public: 1).limit(50)
    respond_to do |format|
      format.json { 
        render json: @attachments.collect{|a| a.to_jq_upload }.to_json 
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
    @attachment = Attachment.find(params[:id])
    respond_to do |format|
      if @attachment.update_attributes(params[:attachments])
        format.json { head :no_content }
      else 
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
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
