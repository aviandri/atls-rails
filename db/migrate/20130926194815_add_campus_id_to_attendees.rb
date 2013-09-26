class AddCampusIdToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :campus_id, :integer
  end
end
