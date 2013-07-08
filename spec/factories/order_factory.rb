FactoryGirl.define do
	factory :order do
		payment_amount 4500000
		payment_term_id{FactoryGirl.create(:full_payment).id}
		association :attendee, factory: :attendee		 		
	end

	factory :first_installment_complete, class: Order do
		payment_amount 2000000
		payment_term_id{FactoryGirl.create(:first_installment).id}
		association :attendee, factory: :attendee
		status Order::STATUS_COMPLETED
	end
end