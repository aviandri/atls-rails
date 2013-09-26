require 'spec_helper'
require 'pry'

describe AdminUser do
  
	describe "roles" do
	  before(:each) do
	  	@training_location_jakarta = FactoryGirl.create(:training_location, name: "Jakarta")
	    @training_location_bali = FactoryGirl.create(:training_location, name: "Bali")
	    @admin_user = FactoryGirl.create(:admin_user)	    
	  end

	  it "should have roles attribute" do
	  	stub_const("AdminUser::ROLES", TrainingLocation.all.map{|b|b.name.downcase})
	    @admin_user.roles = [AdminUser::ROLES[1]]
	    @admin_user.is?(AdminUser::ROLES[1]).should eq(true)	    
	  end

	  it "should check if admin user have a particular role" do
	  	stub_const("AdminUser::ROLES", TrainingLocation.all.map{|b|b.name.downcase})
	  	@admin_user.roles = [AdminUser::ROLES[1], AdminUser::ROLES[0]]

	  	@admin_user.is?(AdminUser::ROLES[1]).should eq(true)
	  	@admin_user.is?(AdminUser::ROLES[0]).should eq(true)

	  	@admin_user.is?("superadmin").should eq(false)
	  end

	  it "can manage attendee with in a particular location" do
	  	roles = TrainingLocation.all.map{|b|"#{b.name.downcase}_admin"}
	    stub_const("AdminUser::ROLES", roles)
	   	@admin_user.roles = ["#{@training_location_jakarta.name.downcase}_admin"]
	    @admin_user.authorized_for?(@training_location_jakarta).should eq(true)
	  end

	  it "can manage attendee with in a particular location" do
	  	roles = TrainingLocation.all.map{|b|"#{b.name.downcase}_admin"}
	    @admin_user.authorized_for?(@training_location_jakarta).should eq(false)
	  end

	  it "can manage attendee with in a particular location" do
	  	roles = TrainingLocation.all.map{|b|"#{b.name.downcase}_admin"}
	    @admin_user.authorized_for?(nil).should eq(false)
	  end

	  it "can manage attendee with in a particular location" do
	  	roles = TrainingLocation.all.map{|b|"#{b.name.downcase}_admin"}
	    stub_const("AdminUser::ROLES", roles)
	   	@admin_user.roles = ["#{@training_location_jakarta.name.downcase}_admin", "#{@training_location_bali.name.downcase}_admin"]
	    @admin_user.authorized_for?(@training_location_jakarta).should eq(true)
	    @admin_user.authorized_for?(@training_location_bali).should eq(true)
	  end

	  it "should return all the training location the admin user have authorization to" do
	    roles = TrainingLocation.all.map{|b|"#{b.name.downcase}_admin"}
	    stub_const("AdminUser::ROLES", roles)
	    @admin_user.roles = ["#{@training_location_jakarta.name.downcase}_admin", "#{@training_location_bali.name.downcase}_admin"]
	    locations = @admin_user.authorized_locations
	    locations.count.should eq(2)
	    locations.include?(@training_location_jakarta).should eq(true)
	    locations.include?(@training_location_bali).should eq(true)
	  end
	end

end