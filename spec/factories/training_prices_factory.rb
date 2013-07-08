# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :training_price do
    training_location
    price 4500000
  end
end
