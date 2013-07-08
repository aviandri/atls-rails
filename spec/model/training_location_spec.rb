require 'spec_helper'

describe TrainingLocation do

	before(:each) do
		@training_location = FactoryGirl.create(:training_location)
	end

	it 'should return first installment amount' do
		@training_location.first_installment.should eq(@training_location.price/2)
	end


end