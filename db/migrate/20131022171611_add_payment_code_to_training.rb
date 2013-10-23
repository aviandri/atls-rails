class AddPaymentCodeToTraining < ActiveRecord::Migration
  def change
    add_column :trainings, :payment_code, :integer
  end
end
