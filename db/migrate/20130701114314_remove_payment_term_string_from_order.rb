class RemovePaymentTermStringFromOrder < ActiveRecord::Migration
  def up
  	remove_column :orders, :payment_term
  end

  def down
  end
end
