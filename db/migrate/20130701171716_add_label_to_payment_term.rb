class AddLabelToPaymentTerm < ActiveRecord::Migration
  def change
  	add_column :payment_terms, :label, :string
  end
end
