class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :training_id
      t.date :payment_date
      t.string :status

      t.timestamps
    end
  end
end
