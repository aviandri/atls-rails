class ChangeScoreOnTrainingsToDecimal < ActiveRecord::Migration
  def up
  	change_column :trainings, :score, :decimal, scale: 2 
  end

  def down
  end
end
