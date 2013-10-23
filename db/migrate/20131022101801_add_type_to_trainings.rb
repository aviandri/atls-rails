class AddTypeToTrainings < ActiveRecord::Migration
  def change
    add_column :trainings, :type, :string
  end
end
