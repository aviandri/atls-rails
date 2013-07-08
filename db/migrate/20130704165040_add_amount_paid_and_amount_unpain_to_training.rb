class AddAmountPaidAndAmountUnpainToTraining < ActiveRecord::Migration
  def change
  	add_column :trainings, :amount_paid, :integer
  	add_column :trainings, :amount_unpaid, :integer
  end
end
