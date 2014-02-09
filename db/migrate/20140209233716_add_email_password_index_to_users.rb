class AddEmailPasswordIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, [:email, :password]
  end
end
