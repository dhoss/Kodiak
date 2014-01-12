class CreatePostsAttachments < ActiveRecord::Migration
  def change
    create_table :posts_attachments, :id => false do |t|
      t.references :post,       :null => false
      t.references :attachment, :null => false
    end

    add_index(:posts_attachments, [:post_id, :attachment_id], :unique => true)
  end
end
