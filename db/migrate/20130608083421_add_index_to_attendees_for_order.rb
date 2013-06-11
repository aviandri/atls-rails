class AddIndexToAttendeesForOrder < ActiveRecord::Migration
  def change
  	add_index :attendees, :order_id, :unique => true
  end
end
