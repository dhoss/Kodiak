class AlterPostsChangeParentToParentId < ActiveRecord::Migration
  def change
    rename_column :posts, :parent, :parent_id
  end
end
