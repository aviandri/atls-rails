class AddPriceToTrainingLocation < ActiveRecord::Migration
  def change
  	add_column :training_locations, :price, :integer
  end
end
