FactoryGirl.define do
	factory :admin_user do
		email "admin@example.com"
		password "password01"
		password_confirmation "password01"
	end
end