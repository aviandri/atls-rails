require 'spec_helper'

describe Order do

	before(:each) do
		@attendee = FactoryGirl.create(:attendee)

		@order = FactoryGirl.create(:order, :attendee_id => @attendee.id)
	end

	describe "create completed payment order" do
		before do
			@training_location = FactoryGirl.create(:training_location)
			@training = Training.new(training_location: @training_location)
			@attendee.training = @training
			@attendee.save
		end
		it "should create order with completed payment" do
			order = Order.create_completed_payment_order(@attendee, @training_location)
			
			order.status.should eq(Order::STATUS_COMPLETED)			
			order.payment_amount.should eq(@training_location.price)
			order.attendee_id.should eq(@attendee.id)
			@training.payment_status.should eq("Done")
		end
	end
end