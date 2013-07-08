class AddPaymentTermToOrder < ActiveRecord::Migration
  def change  	
  	add_column :orders, :payment_term, :string
  end
end
