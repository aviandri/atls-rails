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

  describe "update payment status" do
    before do
      @training_location = FactoryGirl.create(:training_location)
      @training_1 = FactoryGirl.create(:training, training_location: @training_location)            
    end
    it "update payment status" do        
        Training.any_instance.should_receive(:update_payment_status)        
        @training_1.amount_unpaid = 4500000
        @training_1.save        
    end
    it "update status on update instance" do
        training = Training.find @training_1.id
        training.amount_paid = 4500000
        training.save
        training.payment_status.should eq(Training::PAYMENT_STATUSES[0])

        training.payment_complete?.should eq(true)        

        training.amount_paid = 0
        training.save
        training.payment_status.should eq(Training::PAYMENT_STATUSES[1])
        training.payment_not_complete?.should eq(true)
    end
  end

  describe "payment status scopes" do
    before do
      @training_location = FactoryGirl.create(:training_location)
      @training = FactoryGirl.create(:training, training_location: @training_location)            
    end
    it "should return training with payment status belum lunas" do
        Training.payment_not_complete.count.should eq(1)
    end
    it "should return training with payment status lunas" do
        @training.amount_paid = 4500000
        @training.save
        Training.payment_complete.count.should eq(1)
    end
  end



  
end