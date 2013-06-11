class PaymentType < ActiveRecord::Base
  attr_accessible :name
  validate :name, :uniqueness => true
end
