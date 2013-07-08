class AddPaymentAmountToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :payment_amount, :integer
  end
end
