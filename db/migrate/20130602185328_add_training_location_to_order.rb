class AddTrainingLocationToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :training_location, :string
  end
end
