class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.integer :author
      t.integer :parent
      t.integer :category

      t.timestamps
    end
  end
end
