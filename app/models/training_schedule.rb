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

  def self.find_by_training_location_and_training_date(training_location, training_date)
    training_schedules = TrainingSchedule.where("training_location_id = ? AND training_date = ?", training_location.id, training_date)
    training_schedules.blank? ? nil : training_schedules.first
  end




end
