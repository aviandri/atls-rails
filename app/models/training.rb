class Training < ActiveRecord::Base
	attr_accessible :book_delivery_status, :payment_status, :pretest_status, :training_location, :attendee_id, :amount_paid, :amount_unpaid, :training_location_id, :training_schedule_id
	belongs_to :training_location
	belongs_to :attendee
	belongs_to :training_schedule

	after_initialize :init
	before_save :update_payment_status
	accepts_nested_attributes_for :training_location

	PAYMENT_STATUSES = %w(Complete Not\ Complete)	
	PRETEST_STATUSES = %w(Complete Not\ Complete)	

	BOOK_STATUSES = %w(Delivered Picked\ Up)

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

	def update_amount_paid(order)
		training = order.attendee.training
		training.amount_paid = order.payment_amount		
		training.save
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

	PAYMENT_STATUSES.each do |status_name|
		stat_name = status_name.sub(" ", "_").downcase 
		define_method "payment_#{stat_name}?" do
			stat = payment_status.sub(" ", "_").downcase 
			stat_name == stat
		end
	end
	
end
