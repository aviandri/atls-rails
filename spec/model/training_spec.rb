require 'spec_helper'
require 'pry'
describe Training do
	
	before(:each) do
		@attendee = FactoryGirl.create(:attendee)
		@order = FactoryGirl.create(:order, :attendee_id => @attendee.id, :status => Order::STATUS_COMPLETED)
	end

	it 'should update payment status to first insatallment' do
		training = @attendee.training
		training.latest_payment_status.should eq(PaymentTerm.find_by_name(PaymentTerm::TERM_FULL_PAYMENT).name)
	end

	it 'should update payment status' do
		training = Training.update_payment_status(@order)
		training.payment_status.should eq("Lunas")
	end

	it 'should update payment status' do
		order = FactoryGirl.create(:first_installment_complete, :attendee_id => @attendee.id, :status => Order::STATUS_COMPLETED)
		training = Training.update_payment_status(order)
		training.payment_status.should eq("First Installment")
	end
end