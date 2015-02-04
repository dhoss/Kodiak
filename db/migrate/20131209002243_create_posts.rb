class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.integer :parent
      t.integer :category
      t.integer :user_id

      t.timestamps
    end
    add_foreign_key :posts, :users, on_delete: :cascade
  end
end
