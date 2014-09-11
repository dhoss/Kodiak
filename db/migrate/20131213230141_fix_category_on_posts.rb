class FixCategoryOnPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :category
    add_column :posts, :category_id, :integer
  end

  def down
  end
end
