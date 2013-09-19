class Attendee < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [ :email ]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :orders, :orders_attributes, :training_attributes
  attr_accessible :address, :campus_address, :campus_name, :campus_phone, :date_of_birth, :email, :gender, :job_title, :name, :office_address, :office_name, :office_phone, :phone, :religion, :place_of_birth, :order

  has_many :orders
  has_one :training
  accepts_nested_attributes_for :orders, :training
  validates :address, :date_of_birth, :gender, :name, :place_of_birth, :presence => true
  validates :phone, :presence => true
  validates :email, :presence => true, :email => true
  before_save :create_training

  scope :by_training_location, lambda{|location| joins(:training).where('trainings.training_location_id = ?', location.id) }
  scope :by_training_schedule, lambda{|schedule| joins(:training).where('trainings.training_schedule_id = ?', schedule.id) }
  scope :payment_completed, lambda{ joins(:training).where('trainings.payment_status = ?', Training::PAYMENT_STATUSES[0])}
  scope :pretest_completed, lambda{ joins(:training).where('trainings.pretest_status = ?', Training::PRETEST_STATUSES[0])} 
  

  delegate :training_location, :payment_done?, :pretest_status, :training_schedule, to: :training

  DEFAULT_PASSWORD = "password01"

  def self.eligable_attendee_by_training_schedule(training_schedule)
    Attendee.by_training_schedule(training_schedule).payment_completed.pretest_completed
  end
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

  def self.create_attendee_with_completed_payment(attendee_attr)
    attendee_attr = attendee_attr.merge(password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD)
    training = Training.new(attendee_attr[:training_attributes])

    attendee = Attendee.new(attendee_attr)
    attendee.training = training

    Order.create_completed_payment_order(attendee, training.training_location)
    attendee.save
    attendee
  end

  def self.update_attendee_with_completed_payment(attendee_id, attendee_attr)
    attendee = Attendee.find attendee_id
    attendee.update_attributes(attendee_attr)
    attendee
  end

  def create_completed_order(training_location_id)
    training_location = TrainingLocation.find(training_location_id)
    order = Order.new(attendee: self.id)
  end

  def training_location_name
    self.training_location.name
  end

  private
  def create_training  
      unless self.training        
        self.training = Training.new
      end
  end

end
