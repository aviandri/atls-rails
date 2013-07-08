require 'spec_helper'

feature 'View login page' do 
	scenario 'users sees login form when dont have login session' do
		visit new_attendee_session_path
		expect(page).to have_content 'Login'
	end

	scenario 'user login and see home view' do
		FactoryGirl.create(:attendee)
		visit new_attendee_session_path
		expect(page).to have_content 'Login'
		fill_in "attendee_email", :with => 'test@gmail.com'
		fill_in "attendee_password", :with => 'password01'
		click_button "Sign in"
		expect(page).to have_content 'Kursus ATLS'
	end

	scenario 'user login and see home view' do
		FactoryGirl.create(:attendee)
		visit new_attendee_session_path
		expect(page).to have_content 'Login'
		fill_in "attendee_email", :with => 'test@gmail.com'
		fill_in "attendee_password", :with => 'password01'
		click_button "Sign in"
		expect(page).to have_content 'Kursus ATLS'
	end
	
end