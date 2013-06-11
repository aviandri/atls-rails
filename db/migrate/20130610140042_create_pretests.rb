class CreatePretests < ActiveRecord::Migration
  def change
    create_table :pretests do |t|
      t.string :question
      t.string :answer_one
      t.string :answer_two
      t.string :answer_three
      t.string :answer_four
      t.integer :correct_answer

      t.timestamps
    end
  end
end
