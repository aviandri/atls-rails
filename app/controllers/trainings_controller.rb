class TrainingsController < ApplicationController
	layout "home", :only => [:index, :show, :new, :create]


	def show		
		@training = Training.find(params[:id])
		respond_to do |format|
			format.json { render :json => @training}
			format.html{}
		end
	end

	def index
		# @att = Attendee.find(params[:id])
		# authorize! :read, @att
		@trainings = current_attendee.trainings.sort_by_created_at
	end

	def new
		session[:training_params] ||= {}
		@training  = Training.new(session[:training_param])
	end

	def create				
		session[:training_params].deep_merge!(params[:training]) if params[:training]
		klass = session[:training_params]["type"]
		@training = klass.constantize.new(session[:training_params])
		@training.current_step = session[:current_step]	

		if(@training.current_step == "payment")
			binding.pry
			session[:training_params].merge!("payment_code" => Training.generate_payment_code)
		end
		
		if params[:back_button]
			@training.previous_step
		elsif @training.last_step?
			@training.payment_status = "Pending"
			@training.attendee = current_attendee
			@training.save
		else
			@training.next_step
		end

		session[:current_step] = @training.current_step
		if @training.new_record?
      		render 'new'
    	else
    		session[:current_step] = session[:training_params] = nil
	      	redirect_to :action => :index
    	end
	end

	def update
		@training = Training.find(params[:id])
		if params["training_date"]
			training_schedule = TrainingSchedule.find_by_training_date(Date.parse(params["training_date"]))
			@training.training_schedule = training_schedule
		end
		@training.update_attributes(params["training"])
		@training.save
		redirect_to :controller => :homes, :action => :index
	end
end
