# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    training_id 1
    payment_date "2013-11-27"
    status "MyString"
    amount 1
  end
end
