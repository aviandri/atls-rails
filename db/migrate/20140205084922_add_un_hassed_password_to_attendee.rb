class AddUnHassedPasswordToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :plain_password, :string
    
  end
end
