class RemoveTraningLocationFromOrders < ActiveRecord::Migration
  def up
  	remove_column :orders, :training_location
  end

  def down
  end
end
