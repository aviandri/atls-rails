class AddRolesMaskToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :bigint
  end
end
