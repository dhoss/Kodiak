class AddGalleryForeignKeyToAttachments < ActiveRecord::Migration
  def change
    add_foreign_key :attachments, :galleries, on_delete: :cascade
  end
end
