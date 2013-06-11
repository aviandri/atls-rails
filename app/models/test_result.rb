class TestResult < ActiveRecord::Base
  attr_accessible :number_of_question, :score, :attendee
  belongs_to :attendee

end
