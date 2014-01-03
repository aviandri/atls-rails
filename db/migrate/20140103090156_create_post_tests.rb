class CreatePostTests < ActiveRecord::Migration
  def change
    create_table :post_tests do |t|
      t.string :question
      t.string :answer_one
      t.string :answer_two
      t.string :answer_three
      t.string :answer_four
      t.string :answer_five
      t.integer :correct_answer

      t.timestamps
    end
  end
end
