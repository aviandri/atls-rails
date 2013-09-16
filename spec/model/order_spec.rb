require 'spec_helper'
require 'pry'

describe Order do	
	describe "Update order status" do
	  it "should call update training payment data" do	  	
	    order = FactoryGirl.create(:order)
	    order.should_receive(:update_training_payment_data)
	    order.run_callbacks(:save)
	  end

	  it "should call Training.update_payment_status" do
	  	Training.any_instance.should_receive(:update_amount_paid)
	    order = FactoryGirl.create(:order, status: Order::STATUS_COMPLETED)
	  end

	  it "should not call Training.update_payment_status" do
	  	Training.any_instance.should_not_receive(:update_amount_paid)
	  	order = FactoryGirl.create(:order)	    
	  end

	  it "should not call Training.update_payment_status on update" do
	  	order = FactoryGirl.create(:order)	    
	  	Training.any_instance.should_receive(:update_amount_paid)
	  	order.status = Order::STATUS_COMPLETED
	  	order.save
	  end

	  it "should not call Training.update_payment_status on update" do
	  	order = FactoryGirl.create(:order)	    
	  	Training.any_instance.should_not_receive(:update_amount_paid)
	  	order.status = "not completed"
	  	order.save
	  end


	end
end