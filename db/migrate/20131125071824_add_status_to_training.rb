class AddStatusToTraining < ActiveRecord::Migration
  def change
    add_column :trainings, :status, :string
  end
end
