class CreateAttachmentsPosts < ActiveRecord::Migration
  def change
    create_table :attachments_posts, :id => false do |t|
      t.references :post,       :null => false
      t.references :attachment, :null => false
    end

    add_index(:attachments_posts, [:post_id, :attachment_id], :unique => true)
  end
end
