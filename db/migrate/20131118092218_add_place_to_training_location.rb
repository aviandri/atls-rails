class AddPlaceToTrainingLocation < ActiveRecord::Migration
  def change
    add_column :training_locations, :place, :string
  end
end
