class CreatePaymentCodeCounters < ActiveRecord::Migration
  def change
    create_table :payment_code_counters do |t|
      t.integer :index

      t.timestamps
    end
  end
end
