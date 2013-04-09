class AddOrderIdToAttendee < ActiveRecord::Migration
  def change
  	add_column :attendees, :order_id, :integer
  end
end
