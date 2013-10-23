class PaymentType < ActiveRecord::Base
  attr_accessible :name, :account_number, :account_holder, :branch_name
  validate :name, :uniqueness => true
end
