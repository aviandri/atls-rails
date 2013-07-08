class Training < ActiveRecord::Base
	attr_accessible :book_delivery_status, :payment_status, :pretest_status, :training_location, :attendee_id, :amount_paid, :amount_unpaid, :training_location_id, :training_schedule_id
	belongs_to :training_location
	belongs_to :attendee
	belongs_to :training_schedule

	accepts_nested_attributes_for :training_location

	def latest_payment_status
		if self.attendee.orders.completed.latest
			self.attendee.orders.completed.latest.first.payment_term.name
		else	
			nil
		end
	end

	def self.update_payment_status(order)
		if order.status_changed?
			if order.status == Order::STATUS_COMPLETED
				training = order.attendee.training
				current_paid = training.amount_paid.nil? ? 0 : training.amount_paid
				binding.pry
				training.amount_paid = current_paid + order.payment_amount
				if training.amount_paid < training.training_location.price
					training.payment_status = "First Payment"
				elsif training.amount_paid == training.training_location.price
					training.payment_status = "Done"
				end					
				training.save!		
			end
		end
	end

	def payment_done?
		if payment_status == "Done"
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
