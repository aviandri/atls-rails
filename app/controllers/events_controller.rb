class EventsController < ApplicationController
	LIMIT_PER_PAGE = 8

	def show
		@event = Event.find(params[:id])
	end

	def index
		page = 1  	
		if params[:page]
			page = params[:page]
		end

		offset = page * LIMIT_PER_PAGE

		if page.to_i == 1
			offset = 0
		end

		@events = Event.find(:all, 
			:order => "created_at DESC", 
			:limit => LIMIT_PER_PAGE, 
			:offset => offset)

		@page = Event.all.count/LIMIT_PER_PAGE
		@current_page = page
	end
end
