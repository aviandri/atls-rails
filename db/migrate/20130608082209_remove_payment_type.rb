class RemovePaymentType < ActiveRecord::Migration	
  def up
  	remove_column :orders, :payment_type
  end

  def down
  end
end
