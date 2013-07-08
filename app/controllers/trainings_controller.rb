class TrainingsController < ApplicationController

	def show		
		@training = Training.find(params[:id])
		respond_to do |format|
			format.json { render :json => @training}
		end
	end

	def update
		@training = Training.find(params[:id])
		if params["training_date"]
			training_schedule = TrainingSchedule.find_by_training_date(Date.parse(params["training_date"]))
			@training.training_schedule = training_schedule
			binding.pry
		end
		@training.update_attributes(params["training"])
		@training.save
		binding.pry
		redirect_to :controller => :homes, :action => :index
	end
end
