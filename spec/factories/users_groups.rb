# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :users_group do
    name "MyString"
    group_access 1
    group_id 1
    notification_level 1
  end
end
