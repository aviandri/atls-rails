class AddDescriptionToTraining < ActiveRecord::Migration
  def change
    add_column :trainings, :description, :string
  end
end
