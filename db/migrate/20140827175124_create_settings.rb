class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.hstore :configuration
    end
  end
end
