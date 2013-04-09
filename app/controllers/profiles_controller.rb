class ProfilesController < ApplicationController
  LIMIT_PER_PAGE = 8

  def index  
  	page = 1  	
  	if params[:page]
  		page = params[:page]
  	end

  	offset = page * LIMIT_PER_PAGE

  	if page.to_i == 1
  		offset = 0
  	end

  	@profiles = Profile.find(:all, 
  		:order => "created_at", 
  		:limit => LIMIT_PER_PAGE, 
  		:offset => offset)

  	@page = Profile.all.count/LIMIT_PER_PAGE
  	@current_page = page
  end

end
