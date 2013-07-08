class AddPaymentTermIdToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :payment_term_id, :integer
  end
end
