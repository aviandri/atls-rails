class CreatePaymentTerms < ActiveRecord::Migration
  def change
    create_table :payment_terms do |t|
      t.string :name
      t.integer :amount

      t.timestamps
    end
  end
end
