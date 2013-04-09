class Order < ActiveRecord::Base
  attr_accessible :payment_type, :status, :attendees, :attendees_attributes
  has_many :attendees
  accepts_nested_attributes_for :attendees
end
