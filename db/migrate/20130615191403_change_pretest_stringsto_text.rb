class ChangePretestStringstoText < ActiveRecord::Migration
  def up
  	change_column :pretests, :question, :text, :limit => nil
  	change_column :pretests, :answer_one, :text, :limit => nil
  	change_column :pretests, :answer_two, :text, :limit => nil
  	change_column :pretests, :answer_three, :text, :limit => nil
  	change_column :pretests, :answer_four, :text, :limit => nil
  	change_column :pretests, :answer_five, :text, :limit => nil
  end

  def down
  end
end
