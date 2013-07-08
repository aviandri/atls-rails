class RemoveTraningLocationFromTraining < ActiveRecord::Migration
  def up
  	remove_column :trainings, :traning_location_id  	  	
  end

  def down
  end
end
