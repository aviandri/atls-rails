require 'spec_helper'
require 'pry'

describe Ability do

  describe "should be able to test permission" do
  	before(:each) do
  		@admin_user = FactoryGirl.create(:admin_user)  		
  		@training_location_jakarta = FactoryGirl.create(:training_location, name: "Jakarta")
	    @training_location_bali = FactoryGirl.create(:training_location, name: "Bali")	    
	    @attendee = FactoryGirl.create(:attendee)
	    @attendee.training.training_location = @training_location_jakarta
  	end
    it "should description" do
      	stub_const("AdminUser::ROLES", TrainingLocation.all.map{|b|"#{b.name.downcase}_admin"})
	    @admin_user.roles = [AdminUser::ROLES[0]]
	    ability = Ability.new(@admin_user)
	   	   
	    ability.can?(:create, @attendee).should eq(true)
    end
  end
  
end