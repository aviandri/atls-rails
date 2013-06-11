class AddNameToPaymentType < ActiveRecord::Migration
  def change
  	add_column :payment_types, :name, :string
  end
end
