class AddTrainingLocationToTrainings < ActiveRecord::Migration
  def change
  	add_column :trainings, :training_location_id, :integer
  end
end
