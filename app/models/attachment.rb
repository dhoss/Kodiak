require 'carrierwave/orm/activerecord'

class Attachment < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :attachable, polymorphic: true
  belongs_to :gallery
  mount_uploader :attachment, AttachmentUploader

  scope :photos, -> { where(public: 1, mime: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']) }
end
