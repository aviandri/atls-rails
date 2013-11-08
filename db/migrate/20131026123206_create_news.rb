class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :body
      t.string :title

      t.timestamps
    end
  end
end
