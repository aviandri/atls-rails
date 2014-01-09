class TestResult < ActiveRecord::Base
  attr_accessible :number_of_question, :score, :attendee, :attendee_id, :type
  belongs_to :attendee
  belongs_to :training

end


class PostTestResult < TestResult

	def self.passed_test?(training_id)
		training = Training.find training_id		
		result = training.post_test_results.map.reject{|t|t.score / t.number_of_question * 100 < 70 }
		!result.empty?
	end

	def is_test_passed?
		(self.score * 100 / self.number_of_question) >= 70
	end

end

class PreTestResult < TestResult

end
