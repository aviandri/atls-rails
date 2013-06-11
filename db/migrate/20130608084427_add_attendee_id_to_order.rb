class AddAttendeeIdToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :attendee_id, :integer
  end
end
