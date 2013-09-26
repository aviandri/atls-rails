class HomesController < ApplicationController
	layout "home"
	respond_to :json, :only => [:payment_terms]

	def index
		@training_locations = TrainingLocation.all
		@order = Order.new
	end

	def start_test

	end

	def change_password
		@attendee = current_attendee
		
	end

	def update_password		
		@attendee = current_attendee
		if @attendee.update_with_password(params[:attendee])
      		sign_in(@attendee, :bypass => true)
      		flash[:info] = "You have change your password"
		end
		render "change_password"
	end

	def edit_profile
		@attendee = current_attendee
	end

	def update_profile
		@attendee = Attendee.find(params[:id])
		if @attendee.update_attributes(params[:attendee])
			flash[:info] = "You have successfully updated your profile"
			render "edit_profile"
		else
			flash[:error] = "Ooops there is something wrong, please check again your entry"
			render "edit_profile"
		end
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
