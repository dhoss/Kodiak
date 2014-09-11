class AddIdTypeIndexesToAttachments < ActiveRecord::Migration
  def change
    add_index :attachments, :attachable_id
    add_index :attachments, :attachable_type
    add_index :attachments, [:attachable_type, :attachable_id]
  end
end
