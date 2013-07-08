require 'spec_helper'

describe Order do

	before(:each) do
		@attendee = FactoryGirl.create(:attendee)
		@order = FactoryGirl.create(:order, :attendee_id => @attendee.id)
	end

	it 'should approve order' do
		order = Order.approve_order(@order.id)
		order.status.should eq(Order::STATUS_COMPLETED)
		order.payment_term eq(PaymentTerm.find_by_name(PaymentTerm::TERM_FULL_PAYMENT))

		# attendee = Attendee.find(@attendee.id)
		# attendee.training.payment_status.should eq(PaymentTerm::TERM_FIRST_INSTALLMENT) 
	end
end