class AddTrainingScheduleToTraining < ActiveRecord::Migration
  def change
  	add_column :trainings, :training_schedule_id, :integer
  end
end
