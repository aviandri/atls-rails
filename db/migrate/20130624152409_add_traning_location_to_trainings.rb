class AddTraningLocationToTrainings < ActiveRecord::Migration
  def change
  	add_column :trainings, :traning_location_id, :integer
  end
end
