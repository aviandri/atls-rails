# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if(PaymentTerms.all.count == 0) 
	paymentTerms = PaymentTerm.create([{name:"full_payment", amount:4500000, label: "Full Payment"}, 
								{name:"first_installment", amount:2000000, label: "First Installment"},
								{name:"second_installment", amount:2500000, label: "Second Installment"}])
end


