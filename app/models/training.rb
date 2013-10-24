class Training < ActiveRecord::Base
	attr_accessible :book_delivery_status, :payment_status, :pretest_status, :training_location, :attendee_id, :amount_paid, :amount_unpaid, :training_location_id, :training_schedule_id, :payment_type_id, :payment_code, :type
	attr_writer :current_step

	belongs_to :training_location
	belongs_to :attendee
	belongs_to :training_schedule

	belongs_to :payment_type

	after_initialize :init
	accepts_nested_attributes_for :training_location

	PAYMENT_STATUSES = %w(Lunas Belum\ Lunas Pending Batal)	
	PRETEST_STATUSES = %w(Complete Not\ Complete)	

	BOOK_STATUSES = %w(Delivered Picked\ Up)

	TRAINING_TYPES = %w(RegularTraining)

	PAYMENT_CODE_MOD_WEIGH = 200

	scope :sort_by_created_at, order("created_at desc")

	PAYMENT_STATUSES.each do |status_name|
		stat_name = status_name.sub(" ", "_").downcase 
		scope "payment_#{stat_name}", where(:payment_status => status_name)					
	end

	def init
		unless self.amount_paid
			self.amount_paid = 0			
		end
		unless self.pretest_status
			self.pretest_status = PRETEST_STATUSES[1]
		end
	end

	def latest_payment_status
		if self.attendee.orders.completed.latest
			self.attendee.orders.completed.latest.first.payment_term.name
		else	
			nil
		end
	end

	def confirm_payment
		self.amount_paid = self.total_price
		self.save
	end

	def payment_done?
		unless training_location
			return false
		end
		if amount_paid >= training_location.price
			true
		else
			false
		end
	end

	def pretest_done?
		if pretest_status == PRETEST_STATUSES[0]
			true
		else
			false
		end
	end

	def self.update_pretest_result(attendee)
		training = attendee.training
		training.pretest_status = PRETEST_STATUSES[0]
		training.save		
	end

	def update_payment_status
		unless training_location
			return nil
		end
		if amount_paid >= training_location.price
			self.payment_status = PAYMENT_STATUSES[0]
		else
			self.payment_status = PAYMENT_STATUSES[1]
		end
	end

	def steps
		%w[details payment summary]
	end

	def current_step
		@current_step || steps.first
	end

	def next_step
		self.current_step = steps[steps.index(current_step)+1]
	end

	def previous_step
		self.current_step = steps[steps.index(current_step)-1]
	end

	def last_step?
		self.current_step == steps.last
	end

	def first_step?
		self.current_step == step.first
	end

	def self.generate_payment_code
		Training.last.id % PAYMENT_CODE_MOD_WEIGH
	end

	PAYMENT_STATUSES.each do |status_name|
		stat_name = status_name.sub(" ", "_").downcase 
		define_method "payment_#{stat_name}?" do
			stat = payment_status.sub(" ", "_").downcase 
			stat_name == stat
		end
	end	

	def price
		0
	end

	def status		
		if amount_paid >= 0 && amount_paid < total_price
			PAYMENT_STATUSES[1]
		elsif payment_status == PAYMENT_STATUSES[3]
			payment_status
		elsif amount_paid >= total_price
			PAYMENT_STATUSES[0]					
		else
			payment_status
		end						
	end


	def total_price
		price + (payment_code || 0)
	end

end


class RegularTraining < Training
	def price
		training_location.nil? ? 0 : training_location.price
	end

	def description
		"Training ATLS Regular"
	end	
end
