class HomesController < ApplicationController
	layout "home"

	def index
		@orders = current_attendee.orders
		@order = Order.new
	end

	def start_test

	end

	def finish_test
		@test_result = TestResult.order("created_at desc").first
		@is_pass_test = is_pass_test(@test_result)
	end


	private

	def is_pass_test(test_result)
		if (test_result.score/test_result.number_of_question * 10) > 8
			true
		else
			false
		end
	end
end
