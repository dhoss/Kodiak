class RenamePostTagsToPostsTags < ActiveRecord::Migration
  def up
    rename_table :posts_tag, :posts_tag
  end

  def down
  end
end
