class AddUniqueNameToGallery < ActiveRecord::Migration
  def change
    add_index :galleries, :name, :unique => true
  end
end
