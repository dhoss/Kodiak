class AddTrigramIndexOnPosts < ActiveRecord::Migration
  def change
    execute 'CREATE INDEX trgm_idx 
             ON posts 
             USING gin(
               title gin_trgm_ops, 
               body gin_trgm_ops
             )'
  end
end
