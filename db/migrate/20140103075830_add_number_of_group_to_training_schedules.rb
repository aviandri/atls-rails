class AddNumberOfGroupToTrainingSchedules < ActiveRecord::Migration
  def change
    add_column :training_schedules, :number_of_group, :integer
  end
end
