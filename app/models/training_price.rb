class TrainingPrice < ActiveRecord::Base
  attr_accessible :price, :training_location_id
  attr_reader :first_installment
  belongs_to :training_location

  def first_installment
  	price / 2
  end
end
