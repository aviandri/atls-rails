class TrainingsController < ApplicationController
	layout "home", :only => [:index, :show, :new]

	def show		
		@training = Training.find(params[:id])
		respond_to do |format|
			format.json { render :json => @training}
			format.html{

			}
		end
	end

	def index
		# @att = Attendee.find(params[:id])
		# authorize! :read, @att
		@trainings = current_attendee.trainings
	end

	def new
		@training  = Training.new
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
