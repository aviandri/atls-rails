class AddPlaceOfBirthAndTrainingLocationToAttendee < ActiveRecord::Migration
  def change
  	add_column :attendees, :place_of_birth, :string
  	add_column :attendees, :training_location, :string
  end
end
