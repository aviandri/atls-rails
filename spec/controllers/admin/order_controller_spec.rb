require 'spec_helper'
include Devise::TestHelpers

describe Admin::OrdersController do
render_views

	before(:each) do
		@admin = FactoryGirl.create(:admin_user)
		sign_in @admin
	end

	describe "Approve order" do
		before(:each) do
			@attendee = FactoryGirl.create(:attendee)
			@order = FactoryGirl.create(:order, :attendee => @attendee)
			put :approve, :id => @order.id
		end

		it "should update order status and training status" do
									
		end
	end



	
end