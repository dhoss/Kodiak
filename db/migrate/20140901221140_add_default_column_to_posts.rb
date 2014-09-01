class AddDefaultColumnToPosts < ActiveRecord::Migration
  def change
    change_column :posts, :kind, :string, :default => "post"
  end
end
