class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
  	if resource.class.name == "Attendee"
  		home_path
  	else
  		super
  	end
  end


end
