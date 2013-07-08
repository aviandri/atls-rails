class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.integer :attendee_id
      t.string :payment_status
      t.string :book_delivery_status
      t.string :pretest_status

      t.timestamps
    end
  end
end
