class AddGraduationYearToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :graduation_year, :integer
  end
end
