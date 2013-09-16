require 'spec_helper'
require 'pry'
describe Training do
  
  before(:each) do
    @training = FactoryGirl.create(:training)
  end

  describe "is payment done" do
    before do
      @training_location = FactoryGirl.create(:training_location)
      @training_in_jakarta = FactoryGirl.create(:training, training_location: @training_location)
    end
    it "should raise exception because no training location selected" do
       @training.payment_done?.should eq(false)
    end
    it "should return false" do
      @training_in_jakarta.payment_done?.should eq(false)
    end
    it "should return true" do
        @training_in_jakarta.amount_paid = @training_location.price
        @training_in_jakarta.payment_done?.should eq(true)
    end
  end

  describe "update amount paid" do
    before do
      @attendee = FactoryGirl.create(:attendee, :email => "lalala@gmail.com")
      @order = FactoryGirl.create(:order, attendee: @attendee)
      
    end
    it "should update amount paid" do
      @attendee.training.training_location = FactoryGirl.create(:training_location)
      @attendee.training.update_amount_paid(@order)
      @attendee.training.amount_paid.should eq(@order.payment_amount)
      @attendee.training.payment_done?.should eq(true)
    end
  end

  
end