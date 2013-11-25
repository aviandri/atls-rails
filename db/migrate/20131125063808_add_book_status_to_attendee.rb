class AddBookStatusToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :book_status, :string
  end
end
