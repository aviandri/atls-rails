# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bank_account do
    bank_name "MyString"
    account_holder "MyString"
    bank_branch "MyString"
    account_number "MyString"
  end
end
