class TrainingSchedule < ActiveRecord::Base
  attr_accessible :training_date, :training_location_id
  belongs_to :training_location
  has_one :training

  validates_presence_of :training_date, :training_location


end
