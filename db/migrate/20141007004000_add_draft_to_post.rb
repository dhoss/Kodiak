class AddDraftToPost < ActiveRecord::Migration
  def change
    add_column :posts, :is_public, :integer
  end
end
