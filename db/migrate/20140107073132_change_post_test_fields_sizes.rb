class ChangePostTestFieldsSizes < ActiveRecord::Migration
  def up
  	change_column :post_tests, :question, :string, :limit => nil
  	change_column :post_tests, :answer_one, :string, :limit => nil
  	change_column :post_tests, :answer_two, :string, :limit => nil
  	change_column :post_tests, :answer_three, :string, :limit => nil
  	change_column :post_tests, :answer_four, :string, :limit => nil
  	change_column :post_tests, :answer_five, :string, :limit => nil
  end

  def down
  	
  end
end
