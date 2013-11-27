require 'spec_helper'

describe Payment do
  it{should belong_to(:training)}
  it{should validate_presence_of(:payment_date)}
  it{should validate_presence_of(:status)}
  it{should validate_presence_of(:amount)}
  
  describe "Payment statuses" do
    it "should have status 'belum terkonfirmasi' dan 'terkonfirmasi'" do
      assert_equal 2, Payment::PAYMENT_STATUS.count
      assert_equal Payment::PAYMENT_STATUS[0], "Belum Terkonfirmasi"
      assert_equal Payment::PAYMENT_STATUS[1], "Terkonfirmasi"
    end
  end

  describe "Completed payment" do
    before(:each) do
      2.times do
        FactoryGirl.create(:payment, status: Payment::PAYMENT_STATUS[1])
      end      
    end
    it "should return completed payments" do
        assert_equal 2, Payment.confirmed.count
    end
  end


end