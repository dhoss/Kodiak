class DropAttachments < ActiveRecord::Migration
  def change
    # why doesn't this work: drop_table :attachments, force: :cascade
    execute "drop table #{:attachments} cascade"
  end
end
