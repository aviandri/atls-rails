class AttendeesController < Devise::RegistrationsController
	before_filter :authenticate_attendee!, :except => [:new, :create, :mandiri]

	layout "attendee", :only => [:home]

	def new
		@attendee = Attendee.new
	end

	def create
		super
	end

	def home

	end

	protected

	def after_sign_up_path_for(resource)
		if resource.class.name == "Attendee"
			home_path
		else
			super
		end
  	end



end


