class CreateTrainingLocations < ActiveRecord::Migration
  def change
    create_table :training_locations do |t|
      t.string :name

      t.timestamps
    end
  end
end
