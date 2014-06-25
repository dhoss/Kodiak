require 'carrierwave/orm/activerecord'

class Attachment < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  attr_accessible :name, :path, :mime, :attachment, :public
  belongs_to :attachable, polymorphic: true
  mount_uploader :attachment, AttachmentUploader

  scope :photos, -> { where(public: 1, mime: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']) }
end
