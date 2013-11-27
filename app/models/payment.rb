class Payment < ActiveRecord::Base
  attr_accessible :payment_date, :status, :training_id
  validates_presence_of :status, :payment_date, :amount

  PAYMENT_STATUS = %w(Belum\ Terkonfirmasi Terkonfirmasi)
  belongs_to :training

  scope :confirmed, where('status = ?', PAYMENT_STATUS[1])
end
