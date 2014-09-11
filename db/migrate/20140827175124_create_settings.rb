class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.json :configuration
    end
  end
end
