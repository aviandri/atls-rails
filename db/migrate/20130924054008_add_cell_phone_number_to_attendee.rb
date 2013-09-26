class AddCellPhoneNumberToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :cell_number, :string
  end
end
