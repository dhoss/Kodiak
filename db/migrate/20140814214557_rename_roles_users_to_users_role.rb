class RenameRolesUsersToUsersRole < ActiveRecord::Migration
  def change
    rename_table :roles_user, :users_role
  end
end
