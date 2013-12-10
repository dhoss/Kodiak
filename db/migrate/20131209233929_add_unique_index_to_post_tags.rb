class AddUniqueIndexToPostTags < ActiveRecord::Migration
  def change
    add_index :posts_tag, [:post_id, :tag_id], :unique => true
  end
end
