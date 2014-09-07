class AddPublicColumnToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :is_public, :int, default: 1
  end
end
