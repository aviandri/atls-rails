class PretestsController < ApplicationController

	def index
		if params[:random]
			@pretests = Pretest.all.shuffle		
		else
			@pretests = Pretest.all
		end
		respond_to do |format|
			format.json{render :json =>  @pretests.to_json(:root => true, 
				:only => [:id, :question, :answer_one, :answer_two, :answer_three, :answer_four])}
		end
	end

end