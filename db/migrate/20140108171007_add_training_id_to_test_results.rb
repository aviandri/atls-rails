class AddTrainingIdToTestResults < ActiveRecord::Migration
  def change
    add_column :test_results, :training_id, :integer
  end
end
