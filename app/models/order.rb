class Order < ActiveRecord::Base
  attr_accessible :payment_type, :status, :attendee, :attendee_attributes, :payment_amount, :payment_term_id, :attendee_id, :payment_code
  belongs_to :attendee
  belongs_to :payment_term
  validates_presence_of :attendee, :payment_amount
  after_save :update_training_payment_data, :init_order_invalidator


  STATUS_COMPLETED = "completed"
  STATUS_PENDING = "pending"
  STATUS_CANCELED = "canceled"

  delegate :training, to: :attendee

  TRAINING_PACKAGE_PRICE = 4500000

  ORDER_STATUSES = %w(Completed Pending Cancelled)

  scope :pending, where("status = ?", STATUS_PENDING)
  scope :completed, where("status = ?", STATUS_COMPLETED)
  scope :cancel, where("status = ?", STATUS_CANCELED)

  scope :latest, order("created_at desc").limit(1)

  ORDER_STATUSES.each do |status|
    stat = status.downcase
    scope "#{stat}", where("status = ?", status)
  end

  ORDER_STATUSES.each do |status|
    stat = status.downcase
    define_method "#{stat}?" do
      status == self.status
    end
  end

  def self.approve_order(order_id)
  	order = Order.find(order_id)
  	if order == nil
  		raise ActiveRecord::RecordNotFound
  	end
  	order.status = STATUS_COMPLETED  	
  	order.save
    order
  end

  def self.create_completed_payment_order(attendee, training_location)
    order = Order.create(attendee: attendee, payment_amount: training_location.price, status: Order::STATUS_COMPLETED)
  end

  def cancel_order
    self.status = ORDER_STATUSES[2]
    self.save
  end

  private 

  def update_training_payment_data    
    if self.status_changed?
      if self.status == Order::STATUS_COMPLETED
        self.training.update_amount_paid(self)
      end    
    end
  end

  def init_order_invalidator
    if self.status_changed?
      if self.status == Order::ORDER_STATUSES[1]
        binding.pry
        OrderInvalidatorWorker.perform_in(2.minutes, self.id)
      end
    end
  end
  
end
