class ChangePostsParentNullable < ActiveRecord::Migration
  def change
    change_column :posts, :parent_id, :int, :null => true
  end
end
