class TrainingSchedule < ActiveRecord::Base
  attr_accessible :training_date, :training_location_id
  belongs_to :training_location
  has_one :training

  validates_presence_of :training_date, :training_location

  def self.find_by_training_location_name(location_name)
  	location = TrainingLocation.find_by_name(location_name)
  	if location
  		TrainingSchedule.where("training_location_id = ?", location.id)
  	else
  		[]
  	end
  end




end
