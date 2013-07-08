class AddIndexToPaymentTerm < ActiveRecord::Migration
  def change
  	add_index :payment_terms, :name, :unique => true
  end
end
