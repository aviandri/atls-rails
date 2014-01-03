class Training < ActiveRecord::Base
	attr_accessible :training_location, :attendee_id, :amount_paid, :amount_unpaid, :training_location_id, :training_schedule_id, :payment_type_id, :payment_code, :type, :status, :description, :payments_attributes, :group_number
	attr_writer :current_step

	scope :by_training_schedule, lambda{|schedule| joins(:training).where('trainings.training_schedule_id = ?', schedule.id) }

	belongs_to :training_location
	belongs_to :attendee
	belongs_to :training_schedule

	belongs_to :payment_type
	has_many :payments

	after_initialize :init
	accepts_nested_attributes_for :training_location, :payments

	PAYMENT_STATUSES = %w(Lunas Belum\ Lunas)	

	TRAINING_STATUSES = %w(Batal)

	TRAINING_TYPES = %w(RegularTraining RemedialTraining)

	PAYMENT_CODE_MOD_WEIGH = 200

	scope :sort_by_created_at, order("created_at desc")


	def init
		unless self.amount_paid
			self.amount_paid = 0			
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


	def price
		0
	end

	def payment_status				
		if amount_paid >= price
			PAYMENT_STATUSES[0]
		else
			PAYMENT_STATUSES[1]
		end
	end


	def total_price
		price + (payment_code || 0)
	end

	def amount_paid
		payments.empty? ? 0 : payments.confirmed.sum(:amount)
	end

	def amount_unpaid
		price - amount_paid 
	end

end


class RegularTraining < Training
	def price
		training_location.nil? ? 0 : training_location.price
	end

	def to_s
		"Training ATLS Regular"
	end	
end


class RemedialTraining < Training
	def price
		0
	end

	def to_s
		"Remedial Training"
	end
end
