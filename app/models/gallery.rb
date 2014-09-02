class Gallery < ActiveRecord::Base
  paginates_per APP_CONFIG['posts_per_page']
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :photos, 
    class_name: "Attachment",
    foreign_key: :gallery_id
  has_one :cover, 
    class_name: "Attachment",
    foreign_key: :id
  belongs_to :user
  paginates_per APP_CONFIG['posts_per_page']

  def move_images_to_gallery(images, gallery)
    images.each do |image|
      image.gallery_id = gallery.id
      image.save
    end
  end

end
