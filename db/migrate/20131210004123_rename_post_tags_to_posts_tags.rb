class RenamePostTagsToPostsTags < ActiveRecord::Migration
  def up
    rename_table :post_tags, :posts_tags
  end

  def down
  end
end
