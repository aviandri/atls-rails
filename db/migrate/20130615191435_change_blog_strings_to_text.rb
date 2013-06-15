class ChangeBlogStringsToText < ActiveRecord::Migration
  def up
  	change_column :blogs, :body, :text, :limit => nil
  end

  def down
  end
end
