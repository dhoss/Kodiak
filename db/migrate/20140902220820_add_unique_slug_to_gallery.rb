class AddUniqueSlugToGallery < ActiveRecord::Migration
  def change
    add_index :galleries, :slug, :unique => true
  end
end
