class AddTypesAccountNumberAccountHolderAccountBranchNameToPaymentTypes < ActiveRecord::Migration
  def change
    add_column :payment_types, :type, :string
    add_column :payment_types, :account_number, :string
    add_column :payment_types, :account_holder, :string
    add_column :payment_types, :branch_name, :string
  end
end
