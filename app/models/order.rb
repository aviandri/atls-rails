class Order < ActiveRecord::Base
  attr_accessible :payment_type, :status, :attendee, :attendee_attributes, :training_location
  belongs_to :attendee

  scope :pending, where("status = ?", 'pending')
  scope :completed, where("status = ?", 'completed')
  scope :cancel, where("status = ?", 'canceled')

  
end
