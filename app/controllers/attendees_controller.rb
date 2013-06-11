class AttendeesController < Devise::RegistrationsController
	before_filter :authenticate_attendee!, :except => [:new, :create, :mandiri]

	layout "attendee", :only => [:home]

	def new
		@attendee = Attendee.new
	end

	def create
		@attendee = Attendee.new(params[:attendee])
		respond_to do |format|
			if @attendee.save
				format.html  { redirect_to :action => "home" }
				else
					format.html  { render :action => "new" }					
			end
		end
	end

	def home

	end

	protected

	def after_sign_up_path_for(resource)
		if resource.class.name == "Attendee"
			home_path
		end
  	end



end


