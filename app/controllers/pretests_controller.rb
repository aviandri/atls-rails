class PretestsController < ApplicationController

	def index
		if params[:random]
			@pretests = Pretest.all.shuffle		
		else
			@pretests = Pretest.all
		end
		respond_to do |format|
			format.json{render :json =>  @pretests.to_json( 
				:only => [:id, :question, :answer_one, :answer_two, :answer_three, :answer_four, :answer_five])}
		end
	end

	def start_test

	end

end
