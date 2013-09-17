class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.string :bank_name
      t.string :account_holder
      t.string :bank_branch
      t.string :account_number

      t.timestamps
    end
  end
end
