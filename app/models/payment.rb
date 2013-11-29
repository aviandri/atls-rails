class Payment < ActiveRecord::Base
  attr_accessible :payment_date, :status, :training_id, :amount
  validates_presence_of :status, :amount

  PAYMENT_STATUS = %w(Belum\ Terkonfirmasi Terkonfirmasi)
  belongs_to :training

  scope :confirmed, where('status = ?', PAYMENT_STATUS[1])

  def self.initial_status
  	PAYMENT_STATUS[0]
  end

  def confirm_payment
  	self.status = PAYMENT_STATUS[1]
  	self.save
  end
end
