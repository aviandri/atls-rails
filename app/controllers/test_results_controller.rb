class TestResultsController < ApplicationController
	respond_to :json

	def create		
	  	@test_result = TestResult.new(type: params["type"])
	  	@test_result.attendee = current_attendee
	  	@test_result.score = calculate_score(params[:answers], params["type"])
	  	@test_result.number_of_question = get_number_of_question(params["type"])

      if @test_result.type == "PostTestResult"
        @test_result.training = current_attendee.find_latest_post_test_training
      end

	  	if @test_result.save
        if @test_result.type == "PostTestResult"
            @test_result.training.check_status_after_post_test
        end

	  		render :json => {:status => "ok", 
	  			:score => @test_result.score, 
	  			:number_of_question => @test_result.number_of_question}	  	
	  	else
	  		render :json => {:status => "failed"}
	  	end
  	end

  	def calculate_score(answers, type)
  		@score = 0
  		answers.each do |answer|
  			pretest = find_test_object(type, answer[:id])
  			@score = @score +1  if pretest.correct_answer == answer[:answer].to_i  						
  		end
  		@score
  	end

  	private

  	def get_number_of_question(type)
  		if type == "PostTestResult"
  			PostTest.all.count
  		else type == "PreTestResult"
  			Pretest.all.count
  		end
  	end

  	def find_test_object(type, id)
  		if type == "PostTestResult"
  			PostTest.find(id)
  		elsif type == "PreTestResult"
  			Pretest.find(id)
  		end
  	end
end
