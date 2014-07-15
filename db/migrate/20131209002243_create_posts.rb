class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.integer :parent
      t.integer :category
      t.integer :user_id
      t.foreign_key :users, dependent: :delete

      t.timestamps
    end
  end
end
