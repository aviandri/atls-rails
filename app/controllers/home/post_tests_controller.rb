class Home::PostTestsController < ApplicationController
	layout "home"
	before_filter :authenticate_attendee!

	def index
		if params[:random]
			@post_tests = PostTest.all.shuffle
		else
			@post_tests = PostTest.all	
		end

		respond_to do |format| 
			format.html
			format.json {render json: @post_tests.to_json(:only => [:id, :question, :answer_one, :answer_two, :answer_three, :answer_four, :answer_five])}
		end
		
	end

	def start_test

	end



end
