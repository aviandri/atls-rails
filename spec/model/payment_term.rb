require 'spec_helper'

describe PaymentTerm do

	before(:each) do
		load "#{Rails.root}/db/seeds.rb"
	end
	it 'should have three record' do
		PaymentTerm.all.count eq(3)
	end

end