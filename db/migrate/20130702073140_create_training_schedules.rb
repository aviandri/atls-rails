class CreateTrainingSchedules < ActiveRecord::Migration
  def change
    create_table :training_schedules do |t|
      t.integer :training_location_id
      t.date :training_date

      t.timestamps
    end
  end
end
