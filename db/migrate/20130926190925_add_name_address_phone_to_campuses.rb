class AddNameAddressPhoneToCampuses < ActiveRecord::Migration
  def change
    add_column :campus, :name, :string
    add_column :campus, :address, :string
    add_column :campus, :phone, :string
  end
end
