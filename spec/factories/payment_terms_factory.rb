# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :full_payment, class: PaymentTerm do
    name "full_payment"
    amount 4500000
  end

  factory :first_installment, class: PaymentTerm do
    name "first_installment"
    amount 2000000
  end

  factory :second_installment, class: PaymentTerm do
    name "second_installment"
    amount 2500000
  end
end
