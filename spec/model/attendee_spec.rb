require 'spec_helper'
require 'pry'

describe Attendee do
	
	it 'has a valid factory' do
		attendee = FactoryGirl.create(:attendee)
		attendee.should be_valid
		attendee.training.should_not be_nil
	end	

	describe "create attendee with completed payment" do
		before do
			@training_location = FactoryGirl.create(:training_location)
		end
		it "should create attendee, order with complete payment and training with status completed" do
			attendee_attr = {name: "Aviandri", gender: "Male", email: "aviandri@hotmail.com", address: "address 1", date_of_birth: Time.now, place_of_birth: "Bandung", phone: "2007766", training_attributes: {training_location_id: @training_location.id}}
			attendee = Attendee.create_attendee_with_completed_payment(attendee_attr)

			attendee.name.should eq(attendee_attr[:name])
			attendee.email.should eq(attendee_attr[:email])
			attendee.address.should eq(attendee_attr[:address])
			attendee.date_of_birth.should eq(attendee_attr[:date_of_birth])
			attendee.place_of_birth.should eq(attendee_attr[:place_of_birth])
			attendee.training.training_location_id.should eq(@training_location.id)
			attendee.training.amount_paid.should eq(@training_location.price)
			attendee.training.payment_status.should eq("Done")
			attendee.training.amount_paid.should eq(@training_location.price)

			att = Attendee.find(attendee.id)
			att.training.training_location.id.should eq(@training_location.id)						
		end 		
 	end 
	
	
end
