require 'carrierwave/orm/activerecord'

class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  attr_accessible :name, :path, :mime, :attachment
  mount_uploader :attachment, AttachmentUploader

end
