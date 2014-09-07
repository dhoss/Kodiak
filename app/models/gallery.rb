class Gallery < ActiveRecord::Base
  paginates_per APP_CONFIG['posts_per_page']
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :photos, -> { where(is_public: 1) },
    class_name: "Attachment",
    foreign_key: :gallery_id
  belongs_to :user
  paginates_per APP_CONFIG['posts_per_page']

  def move_images_to_gallery(images, gallery)
    images.each do |image|
      image.gallery_id = gallery.id
      image.save
    end
  end

  def cover_photo
    photos.first.attachment_url(:thumb) || "default.jpg"
  end
end
