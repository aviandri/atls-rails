class AddTrainingScoreToTraining < ActiveRecord::Migration
  def change
    add_column :trainings, :score, :integer
  end
end
