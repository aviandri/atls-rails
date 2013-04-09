class AttendeesController < ApplicationController

	def new
		@attendee = Attendee.new
	end

	def create
		@attendee = Attendee.new(params[:attendee])

		respond_to do |format|
			if @attendee.save
				format.html  { redirect_to(@attendee,
					:notice => 'Post was successfully created.') }
				else
					format.html  { render :action => "new" }					
				end
			end
		end
	end

