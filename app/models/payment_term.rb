class PaymentTerm < ActiveRecord::Base
  attr_accessible :amount, :name, :label
  validates_presence_of :amount
  validates_presence_of :name, :uniqueness => true
  
  has_many :orders

  TERM_FULL_PAYMENT = "full_payment"
  TERM_FIRST_INSTALLMENT = "first_installment"
  TERM_SECOND_INSTALLMENT = "second_installment"
end
