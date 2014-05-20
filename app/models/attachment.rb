require 'carrierwave/orm/activerecord'

class Attachment < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  attr_accessible :name, :path, :mime, :attachment, :public
  belongs_to :attachable, polymorphic: true
  mount_uploader :attachment, AttachmentUploader

  scope :photos, -> { where { mime.in_any ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']} }
 
  def to_jq_upload
    {
      "name"          => read_attribute(:attachment),
      "size"          => attachment.size,
      "url"           => attachment.url,
      "thumbnail_url" => attachment.thumb.url,
      "delete_url"    => attachment_path(:id => id),
      "delete_type"   => "DELETE" 
    }
  end
end
