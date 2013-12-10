class AlterPostsTagsTableNoTimestamps < ActiveRecord::Migration
  def up
    drop_table :posts_tags
    create_table :posts_tags, :id => false do |t|
      t.integer :post_id, :null => false
      t.integer :tag_id,  :null => false
    end

    add_index(:posts_tags, [:post_id, :tag_id], :unique => true)
  end

  def down
  end
end
