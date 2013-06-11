class CreateTestResults < ActiveRecord::Migration
  def change
    create_table :test_results do |t|
      t.integer :attendee_id
      t.integer :score
      t.integer :number_of_question

      t.timestamps
    end
  end
end
