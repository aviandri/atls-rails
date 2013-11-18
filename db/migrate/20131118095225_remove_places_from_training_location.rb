class RemovePlacesFromTrainingLocation < ActiveRecord::Migration
  def up
  	remove_column :training_locations, :place
  end

  def down
  end
end
