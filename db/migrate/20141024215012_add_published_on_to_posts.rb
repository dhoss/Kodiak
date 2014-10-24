class AddPublishedOnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :published_on, :datetime
    remove_column :posts, :is_public
  end
end
