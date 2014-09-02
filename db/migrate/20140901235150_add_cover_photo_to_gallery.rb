class AddCoverPhotoToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :cover, :integer
  end
end
