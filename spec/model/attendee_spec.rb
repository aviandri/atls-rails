require 'spec_helper'
require 'pry'

describe Attendee do
	
	it 'has a valid factory' do
		attendee = FactoryGirl.create(:attendee)
		attendee.should be_valid
	end	
	
end
