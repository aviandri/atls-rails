require 'spec_helper'
include Devise::TestHelpers

describe HomesController do

	before(:each) do
		@attendee = FactoryGirl.create(:attendee)
		sign_in @attendee
	end

	it 'should assign new order and training prices' do
		get :index
		assigns(:training_locations).should_not be_nil
		assigns(:order).should_not be_nil
	end

	
end