require 'carrierwave/orm/activerecord'

class Attachment < ActiveRecord::Base
  attr_accessible :name, :path, :mime, :attachment, :public
  belongs_to :attachable, polymorphic: true
  mount_uploader :attachment, AttachmentUploader
 
  def to_jq_upload
    {
      "name"          => read_attribute(:attachment),
      "size"          => attachment.size,
      "url"           => attachment.url,
      "thumbnail_url" => attachment.thumb.url,
      "delete_url"    => "/attachments/"<< id,
      "delete_type"   => "DELETE" 
    }
  end
end
