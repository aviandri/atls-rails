class RemoveBookDeliveryStatusFromTraining < ActiveRecord::Migration
  def up
  	remove_column :trainings, :book_delivery_status
  end

  def down
  end
end
