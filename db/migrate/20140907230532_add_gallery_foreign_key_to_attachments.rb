class AddGalleryForeignKeyToAttachments < ActiveRecord::Migration
  def change
    change_table :attachments do |t|
      t.foreign_key :galleries, dependent: :delete
    end
  end
end
