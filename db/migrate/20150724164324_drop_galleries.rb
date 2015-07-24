class DropGalleries < ActiveRecord::Migration
  def change
    # why doesn't drop_table :galleries, force: :cascade work?
    execute "drop table #{:galleries} cascade"
  end
end
