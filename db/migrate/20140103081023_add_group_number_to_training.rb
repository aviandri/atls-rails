class AddGroupNumberToTraining < ActiveRecord::Migration
  def change
    add_column :trainings, :group_number, :integer
  end
end
