class ChangePostTestColumnsSizes < ActiveRecord::Migration
  def up
  	change_column :post_tests, :question, :text, :limit => nil
  	change_column :post_tests, :answer_one, :text, :limit => nil
  	change_column :post_tests, :answer_two, :text, :limit => nil
  	change_column :post_tests, :answer_three, :text, :limit => nil
  	change_column :post_tests, :answer_four, :text, :limit => nil
  	change_column :post_tests, :answer_five, :text, :limit => nil
  end

  def down
  end
end
