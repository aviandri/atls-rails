require 'spec_helper'
require 'pry'

describe Attendee do
	
	it 'has a valid factory' do
		attendee = FactoryGirl.create(:attendee)
		attendee.should be_valid
		attendee.training.should_not be_nil
	end	

	it 'should not have duplicate email' do
		FactoryGirl.create(:attendee).should be_valid
		FactoryGirl.build(:attendee).should have(1).error_on(:email)
	end

	it 'should return all of payment term' do
		attendee = FactoryGirl.create(:attendee)
		attendee.available_payment_term.count eq(3)
	end

	it 'should return available payment term when first installment is complete' do
		FactoryGirl.create(:full_payment)
		FactoryGirl.create(:fist_installment)
		FactoryGirl.create(:second_installment)
		order = FactoryGirl.create(:first_installment_complete)
		order.attendee.available_payment_term.count.should eq(1)
		order.attendee.available_payment_term.first.should eq(PaymentTerm.find_by_name(PaymentTerm::TERM_SECOND_INSTALLMENT))
	end
	
end