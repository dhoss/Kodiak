class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :attachable, polymorphic: true
      t.string :name
      t.string :path
      t.string :mime
      t.string :attachment

      t.timestamps
    end
  end
end
