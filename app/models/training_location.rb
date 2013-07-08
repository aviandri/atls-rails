class TrainingLocation < ActiveRecord::Base
  attr_accessible :name, :price
  has_many :training_schedules


  validates_presence_of  :name, :price

  def first_installment
  	price/2
  end

  def payment_terms
  	location = TrainingLocation.find(params[:location_id])

  end

end
