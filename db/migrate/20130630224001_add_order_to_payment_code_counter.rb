class AddOrderToPaymentCodeCounter < ActiveRecord::Migration
  def change
  	add_column :payment_code_counters, :order_id, :integer
  end
end
