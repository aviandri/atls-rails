class AddAnswer5ToPretest < ActiveRecord::Migration
  def change
  	add_column :pretests, :answer_five, :string
  end
end
