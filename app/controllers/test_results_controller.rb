class TestResultsController < ApplicationController
	respond_to :json

	def create		
	  	@test_result = TestResult.new
	  	@test_result.attendee = current_attendee
	  	@test_result.score = calculate_score(params[:answers])
	  	@test_result.number_of_question = Pretest.all.count
	  	if @test_result.save
	  		render :json => {:status => "ok", 
	  			:score => @test_result.score, 
	  			:number_of_question => @test_result.number_of_question}	  	
	  	else
	  		render :json => {:status => "failed"}
	  	end
  	end

  	def calculate_score(answers)
  		@score = 0
  		answers.each do |answer|
  			pretest = Pretest.find(answer[:id])
  			@score = @score +1  if pretest.correct_answer == answer[:answer].to_i  						
  		end
  		@score
  	end
end
