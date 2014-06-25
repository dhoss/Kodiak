class AddOrderByIndexToPosts < ActiveRecord::Migration
  def change
    add_index :posts, [:id, :category_id, :created_at]
  end
end
