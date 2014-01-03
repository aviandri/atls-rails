class TrainingSchedulesController < ApplicationController
	respond_to :json, :only => [:index, :show]

	def index
		if params["training_location_id"]
			@training_schedules = TrainingSchedule.where("training_location_id = ?", params["training_location_id"])			
		else
			@training_schedules = TrainingSchedule.all
		end
	end

	def show
		@training_schedule = TrainingSchedule.find(params[:id])
	end
end
