class AddOrderByIndexToPosts < ActiveRecord::Migration
  def change
    add_index :posts, [:id, :category, :created_at]
  end
end
