class AttendeesController < Devise::RegistrationsController
	before_filter :authenticate_attendee!, :except => [:new, :create, :mandiri, :update]
	layout "attendee", :only => [:home]

	def new
		@attendee = Attendee.new
	end

	def create
		resource.update_attributes(params["attendee"])
		super
	end

	def update
		@attendee = Attendee.find(params[:id])

		if params["training_location"]
			@attendee.training.training_location = TrainingLocation.find(params["training_location"])
			@attendee.training.save
		end		
		binding.pry 
		@attendee.update_attributes(params["attendee"])		
		@attendee.save
		redirect_to :controller => :homes, :action => :index

	end

	def home

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

	protected

	def after_sign_up_path_for(resource)
		if resource.class.name == "Attendee"
			home_path
		else
			super
		end
	end

	private

end


