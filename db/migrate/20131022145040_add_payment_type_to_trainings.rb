class AddPaymentTypeToTrainings < ActiveRecord::Migration
  def change
    add_column :trainings, :payment_type_id, :integer
  end
end
