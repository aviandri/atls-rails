class CreateTrainingPrices < ActiveRecord::Migration
  def change
    create_table :training_prices do |t|
      t.integer :training_location_id
      t.integer :price

      t.timestamps
    end
  end
end
