class AddTsvToPosts < ActiveRecord::Migration
  def change
    execute 'ALTER TABLE posts ADD COLUMN tsv tsvector'
    execute 'CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
    ON posts FOR EACH ROW EXECUTE PROCEDURE
    tsvector_update_trigger(tsv, "pg_catalog.english", title, body);'
  end
end
