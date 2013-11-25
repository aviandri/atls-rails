class RemovePaymentStatusPretestStatusBookStatusFromTraining < ActiveRecord::Migration
  def up
  	remove_column :trainings, :payment_status
  	remove_column :trainings, :pretest_status
  end

  def down
  end
end
