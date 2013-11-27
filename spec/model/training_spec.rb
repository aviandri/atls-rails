require 'spec_helper'
require 'pry'

describe Training do
  let(:training){FactoryGirl.create(:training)}
  let(:location){FactoryGirl.create(:training_location, price: 5000000)}
  let(:training_with_location){FactoryGirl.create(:regular_training, training_location: location)}
  let(:training_with_location_2){FactoryGirl.create(:regular_training, training_location: location)}
  
  it{should have_many(:payments)}  

  describe "Get confirmed payment" do
    before(:each) do
      2.times do
        FactoryGirl.create(:payment, status: Payment::PAYMENT_STATUS[1], training: training)
      end
      FactoryGirl.create(:payment, training: training)
    end
    it "should return confirmed payment" do
      assert_equal 2, training.payments.confirmed.count
      assert_equal 3, training.payments.count
    end
  end

  describe "Payment status" do
    it "should return lunas" do
      2.times do
        FactoryGirl.create(:payment, status: Payment::PAYMENT_STATUS[1], training: training_with_location, amount: 2500000)
      end
      assert_equal Training::PAYMENT_STATUSES[0], training_with_location.payment_status
    end

    it "should return belum lunas no payment done" do
      assert_equal Training::PAYMENT_STATUSES[1], training_with_location_2.payment_status
    end

    it "should return belum lunas, payment available but amount not enough" do
      FactoryGirl.create(:payment, status: Payment::PAYMENT_STATUS[1], training: training_with_location_2, amount: 2500000)
      assert_equal Training::PAYMENT_STATUSES[1], training_with_location_2.payment_status
    end
  end

  describe "Amount Paid and Unpaid" do
    before(:each) do
      2.times do
        FactoryGirl.create(:payment, status: Payment::PAYMENT_STATUS[1], training: training_with_location, amount: 2500000)
      end
    end
    it "should return amount paid" do

      assert_equal 5000000, training_with_location.amount_paid
      assert_equal 0, training_with_location_2.amount_paid
    end
    it "should return amount unpaid" do
      assert_equal 5000000, training_with_location_2.amount_unpaid
      assert_equal 0, training_with_location.amount_unpaid
    end
  end
  
end