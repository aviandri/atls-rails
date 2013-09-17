class BankAccount < ActiveRecord::Base
  attr_accessible :account_holder, :account_number, :bank_branch, :bank_name
end
