class ChangeRolesMaskToBigInt < ActiveRecord::Migration
  def up
  	change_column :admin_users, :roles_mask, :bigint
  end

  def down
  end
end
