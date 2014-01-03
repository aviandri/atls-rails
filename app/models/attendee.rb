class Attendee < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [ :email ]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :orders, :orders_attributes, :training_attributes, :cell_number, :campus
  attr_accessible :address, :campus_address, :campus_name, :campus_phone, :date_of_birth, :email, :gender, :job_title, :name, :office_address, :office_name, :office_phone, :phone, :religion, :place_of_birth, :order, :campus_id, :book_status, :graduation_year

  has_many :orders
  has_many :test_results
  belongs_to :campus
  has_many :trainings
  accepts_nested_attributes_for :orders
  validates :address, :date_of_birth, :gender, :name, :place_of_birth, :presence => true
  validates :phone, :presence => true

  scope :by_training_location, lambda{|location| joins(:trainings).where('trainings.training_location_id = ?', location.id) }
  scope :by_training_schedule, lambda{|schedule| joins(:trainings).where('trainings.training_schedule_id = ?', schedule.id) }
  scope :payment_completed, lambda{ joins(:training).where('trainings.payment_status = ?', Training::PAYMENT_STATUSES[0])}
  scope :pretest_completed, joins(:test_results).uniq
  
  delegate :training_location, to: :training

  BOOK_STATUS = %w(Dikirim Diambil)

  DEFAULT_PASSWORD = "password01"

  def self.eligable_attendee_by_training_schedule(training_schedule)
    Attendee.by_training_schedule(training_schedule)
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
    exl = Roo::Excelx.new("/Users/aviandrihidayat/Documents/projects/atls-rails/atls-sample.xlsx")    
    ((exl.first_row+2)..exl.last_row).each do |i|
      name = exl.cell(i, "B") 
      phone = exl.cell(i, "C")
      campus_name = exl.cell(i, "D")
      campus = Campus.find_by_name(campus_name)      
      office_name = exl.cell(i, "F")
      email = exl.cell(i, "E") || "" + SecureRandom.hex(10) + "@mail.com"
      password = SecureRandom.hex(10)
      dob = "11-08-1984"
      gender = "male"
      address = "Matraman"
      place_of_birth = "Jakarta"


      first_payment = exl.cell(i, "G") || 0
      second_payment = exl.cell(i, "K") || 0
      training_location_name = exl.cell(i, "P")
      training_location = TrainingLocation.find_by_name(training_location_name)
       
      attendee = Attendee.new(:name => name, :phone => phone, 
        :campus => campus, :office_name => office_name,
        :email => email, password: password, password_confirmation: password, date_of_birth: dob, gender: gender, address: address, place_of_birth: place_of_birth)          

      payment_amount = first_payment + second_payment

      training = Training.new(:type => "RegularTraining", training_location: training_location, amount_paid: payment_amount)

      attendee.trainings << training
      a = attendee.save
    end

  end

  def self.create_attendee_with_completed_payment(attendee_attr)
    transaction do 
      attendee_attr = attendee_attr.merge(password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD)
      training = Training.new(attendee_attr[:training_attributes])

      attendee = Attendee.new(attendee_attr)
      attendee.training = training

      Order.create_completed_payment_order(attendee, training.training_location)
      attendee.save
      return attendee
    end    
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

  def is_complete_pretest?
    !test_results.blank?
  end

  private
  def create_training  
      unless self.training        
        self.training = Training.new
      end
  end

end
