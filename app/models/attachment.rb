require 'carrierwave/orm/activerecord'

class Attachment < ActiveRecord::Base
  belongs_to :post_id
  mount_uploader :attachment, AttachmentUploader
  attr_accessible :name, :path, :mime, :attachment
end
