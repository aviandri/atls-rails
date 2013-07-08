class TrainingSchedulesController < ApplicationController
	respond_to :json, :only => [:index]

	def index
		if params["training_location_id"]
			@training_schedules = TrainingSchedule.find_by_training_location_id(params["training_location_id"])
		else
			@training_schedules = TrainingSchedule.all
		end
		
		# render :json => {:training_schedules => @training_schedules}
	end
end
