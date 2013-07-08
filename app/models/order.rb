class Order < ActiveRecord::Base
  attr_accessible :payment_type, :status, :attendee, :attendee_attributes, :payment_amount, :payment_term_id, :attendee_id, :payment_code
  belongs_to :attendee
  belongs_to :payment_term
  validates_presence_of :attendee, :payment_amount
  after_save :update_training_payment_data

  STATUS_COMPLETED = "completed"
  STATUS_PENDING = "pending"
  STATUS_CANCELED = "canceled"

  scope :pending, where("status = ?", STATUS_PENDING)
  scope :completed, where("status = ?", STATUS_COMPLETED)
  scope :cancel, where("status = ?", STATUS_CANCELED)

  scope :latest, order("created_at desc").limit(1)


  def self.approve_order(order_id)
  	order = Order.find(order_id)
  	if order == nil
  		raise ActiveRecord::RecordNotFound
  	end
  	order.status = STATUS_COMPLETED  	
  	order.save
    order
  end


  private 

  def update_training_payment_data
    Training.update_payment_status(self)
  end
  
end
