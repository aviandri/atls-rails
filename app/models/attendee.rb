class Attendee < ActiveRecord::Base
  attr_accessible :address, :campus_address, :campus_name, :campus_phone, :date_of_birth, :email, :gender, :job_title, :name, :office_address, :office_name, :office_phone, :phone, :religion, :place_of_birth, :training_location, :order
  belongs_to :order
  validates :address, :date_of_birth, :gender, :name, :place_of_birth, :training_location, :presence => true
  validates :phone, :presence => true, :numericality => { :only_integer => true }  
  validates :email, :presence => true, :email => true
end
