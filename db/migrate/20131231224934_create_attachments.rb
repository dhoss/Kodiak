class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :path
      t.string :mime
      t.references :post_id, index: true

      t.timestamps
    end
  end
end
