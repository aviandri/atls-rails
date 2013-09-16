class Training < ActiveRecord::Base
	attr_accessible :book_delivery_status, :payment_status, :pretest_status, :training_location, :attendee_id, :amount_paid, :amount_unpaid, :training_location_id, :training_schedule_id
	belongs_to :training_location
	belongs_to :attendee
	belongs_to :training_schedule

	after_initialize :init
	accepts_nested_attributes_for :training_location


	def init
		self.amount_paid = 0
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
		if pretest_status == "Done"
			true
		else
			false
		end
	end

	def self.update_pretest_result(attendee)
		training = attendee.training
		training.pretest_status = "Done"
		training.save		
	end
end
