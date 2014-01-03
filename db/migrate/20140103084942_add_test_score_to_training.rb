class AddTestScoreToTraining < ActiveRecord::Migration
  def change
    add_column :trainings, :test_score, :numeric
  end
end
