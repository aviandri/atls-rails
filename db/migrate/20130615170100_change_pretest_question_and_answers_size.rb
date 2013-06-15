class ChangePretestQuestionAndAnswersSize < ActiveRecord::Migration
  def up
  	change_column :pretests, :question, :string, :limit => nil
  	change_column :pretests, :answer_one, :string, :limit => nil
  	change_column :pretests, :answer_two, :string, :limit => nil
  	change_column :pretests, :answer_three, :string, :limit => nil
  	change_column :pretests, :answer_four, :string, :limit => nil
  	change_column :pretests, :answer_five, :string, :limit => nil
  end

  def down
  end
end
