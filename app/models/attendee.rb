class Attendee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [ :email ]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :orders, :orders_attributes
  attr_accessible :address, :campus_address, :campus_name, :campus_phone, :date_of_birth, :email, :gender, :job_title, :name, :office_address, :office_name, :office_phone, :phone, :religion, :place_of_birth, :order
  has_many :orders
  accepts_nested_attributes_for :orders
  validates :address, :date_of_birth, :gender, :name, :place_of_birth, :presence => true
  validates :phone, :presence => true, :numericality => { :only_integer => true }  
  validates :email, :presence => true, :email => true


end
