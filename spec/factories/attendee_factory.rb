FactoryGirl.define do
	factory :attendee do
		name 	"Test Attendee"
		address "Address 1"
		phone 	"082111111"
		email 	"test@gmail.com"
		password "password01"
  		password_confirmation  "password01"
  		date_of_birth	"01/01/2010"
  		gender 	"male"
  		place_of_birth "bandung"

	end 	
end