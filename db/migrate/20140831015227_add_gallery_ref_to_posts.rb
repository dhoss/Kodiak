class AddGalleryRefToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :gallery, index: true
  end
end
