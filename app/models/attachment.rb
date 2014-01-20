require 'carrierwave/orm/activerecord'

class Attachment < ActiveRecord::Base
  attr_accessible :name, :path, :mime, :attachment
  belongs_to :attachable, polymorphic: true
  mount_uploader :attachment, AttachmentUploader

end
