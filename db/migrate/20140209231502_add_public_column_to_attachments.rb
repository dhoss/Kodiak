class AddPublicColumnToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :public, :int, default: 1
  end
end
