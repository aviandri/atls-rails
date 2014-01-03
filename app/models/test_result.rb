class TestResult < ActiveRecord::Base
  attr_accessible :number_of_question, :score, :attendee, :attendee_id
  belongs_to :attendee
end
