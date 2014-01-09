class AddTypeToTestResult < ActiveRecord::Migration
  def change
    add_column :test_results, :type, :string
  end
end
