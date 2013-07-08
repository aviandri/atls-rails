class Attendee < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [ :email ]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :orders, :orders_attributes
  attr_accessible :address, :campus_address, :campus_name, :campus_phone, :date_of_birth, :email, :gender, :job_title, :name, :office_address, :office_name, :office_phone, :phone, :religion, :place_of_birth, :order
  has_many :orders
  has_one :training
  # has_one :training_location, :through => :training
  accepts_nested_attributes_for :orders
  validates :address, :date_of_birth, :gender, :name, :place_of_birth, :presence => true
  validates :phone, :presence => true
  validates :email, :presence => true, :email => true
  before_save :create_training


  def available_payment_term
    last_order = self.orders.completed.latest == nil ? nil : self.orders.completed.latest.first

    if last_order 
      if last_order.payment_term == PaymentTerm.find_by_name(PaymentTerm::TERM_FIRST_INSTALLMENT)
        @payment_term = PaymentTerm.where("name = ?", PaymentTerm::TERM_SECOND_INSTALLMENT)   
      end
    else
      @payment_term = PaymentTerm.where("name = ? OR name = ?", PaymentTerm::TERM_FIRST_INSTALLMENT, PaymentTerm::TERM_FULL_PAYMENT)   
    end
  end

  def self.import
    exl = Roo::Excelx.new("/Users/aviandrihidayat/Documents/projects/atls-rails/sample.xlsx")    
    ((exl.first_row+2)..exl.last_row).each do |i|
      name = exl.cell(i, "B") 
      phone = exl.cell(i, "C")
      campus_name = exl.cell(i, "D")
      office_name = exl.cell(i, "E")
      email = exl.cell(i, "F")
      first_payment = exl.cell(i, "J")
      second_payment = exl.cell(i, "O")
       
      attendee = Attendee.new(:name => name, :phone => phone, 
        :campus_name => campus_name, :office_name => office_name,
        :email => email)          

      training_location = TrainingLocation.find_by_name("Jakarta")
      training = Training.new(:training_location => training_location)
      attendee.training = training
      attendee.save(:validate => false)

      if first_payment
        attendee.orders << Order.new(:status => "completed", :payment_amount => first_payment)
      end

      if second_payment
        attendee.orders << Order.new(:status => "completed", :payment_amount => second_payment)
      end

      attendee.save(:validate => false)
    end

  end

  private
  def create_training  
      unless self.training        
        self.training = Training.new
      end
  end

end
