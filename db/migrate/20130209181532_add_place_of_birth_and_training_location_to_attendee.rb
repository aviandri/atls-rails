class AddPlaceOfBirthAndTrainingLocationToAttendee < ActiveRecord::Migration
  def change
  	add_column :attendees, :place_of_birth, :string
  end
end
