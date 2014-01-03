class AddNickNameToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :nick_name, :string
  end
end
