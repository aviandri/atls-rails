class HomesController < ApplicationController
	layout "home"
	respond_to :json, :only => [:payment_terms]

	def index
		@training_locations = TrainingLocation.all
		@order = Order.new
	end

	def start_test

	end

	def finish_test
		@test_result = TestResult.order("created_at desc").first
		@is_pass_test = is_pass_test(@test_result)
	end

	def payment_terms
		location = TrainingLocation.find(params[:training_location_id])
		Struct.new("PayTerm", :name, :price)
		if current_attendee.training.amount_paid.nil?
			@payterms = [Struct::PayTerm.new("Lunas", location.price), 
				Struct::PayTerm.new("Cicilan Pertama", location.first_installment)]
			else
				@payterms = [Struct::PayTerm.new("Lunas", location.price - current_attendee.training.amount_paid)]
			end 
			render :json => {:payment_term => @payterms}
		end

	def resource_name
		:attendee
	end

	def resource
		@resource ||= Attendee.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:attendee]
	end


	private

	def is_pass_test(test_result)
		if (test_result.score/test_result.number_of_question * 10) > 8
			true
		else
			false
		end
	end

end
