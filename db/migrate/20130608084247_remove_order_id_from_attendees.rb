class RemoveOrderIdFromAttendees < ActiveRecord::Migration
  def up
  	remove_column :attendees, :order_id
  end

  def down
  end
end
